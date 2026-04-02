#!/usr/bin/env wish

# Create the main window
wm title . "Graph Token Launcher"

# Create a label and an entry widget for the secret input
label .label -text "Enter your access token:"
entry .entry -show "*" -textvariable secret -width 50

# Output text widget for script feedback
text .output -height 8 -width 60 -state disabled -bg black -fg green
scrollbar .scroll -command {.output yview}
.output configure -yscrollcommand {.scroll set}

proc append_output {line} {
    .output configure -state normal
    .output insert end "$line\n"
    .output see end
    .output configure -state disabled
}

# Launch the bash script, passing the token safely (no shell interpolation)
button .launch -text "Launch Script" -command {
    if {$secret eq ""} {
        tk_messageBox -message "Please enter a token first." -icon warning
        return
    }
    append_output "--- Running script.sh ---"
    if {[catch {open [list |bash script.sh $secret] r} file]} {
        append_output "Error: $file"
        return
    }
    while {[gets $file line] >= 0} {
        append_output $line
    }
    if {[catch {close $file} err]} {
        append_output "Script error: $err"
    } else {
        append_output "--- Done ---"
    }
} -bg black -fg white -font {Helvetica 12 bold}

button .exit -text "Exit" -command { exit } -bg red -fg yellow -font {Helvetica 12 bold}

# Arrange the widgets in the window
pack .label   -pady {10 2} -padx 10
pack .entry   -pady 2      -padx 10
pack .launch  -pady 6
pack .output  -pady 4      -padx 10 -fill both -expand 1
pack .scroll  -side right  -fill y
pack .exit    -pady {2 10}

# Start the Tk event loop
tkwait window .
