#!/usr/bin/env wish

puts "Welcome to the Secret Input Program!"
puts "Get the secret from https://developer.microsoft.com/en-us/graph/graph-explorer"

# Create the main window
wm title . "Trainer"

# Create a global variable to store the secret
global secret_value

# Create a label and an entry widget for the secret input
label .label -text "Enter your secret:"
entry .entry -show "*" -textvariable secret

# Create a button to submit the input
button .submit -text "Submit" -command {
    global secret_value
    set secret_value $secret
    tk_messageBox -message "Secret has been stored in memory."
} -bg black -fg white -font {Helvetica 12 bold}

# Create a button to launch the bash script yo.sh with the secret as an argument and print its output to the terminal
button .launch -text "Launch Script" -command {
    global secret_value
    set file [open "|bash script.sh $secret_value" r]
    while {[gets $file line] >= 0} {
        puts $line
    }
    close $file
}

# Create a button to display the stored secret
button .show_secret -text "Show Secret" -command {
    global secret_value
    tk_messageBox -message "Stored secret: $secret_value"
}

# Create a button to exit the program with red background and yellow bold text
button .exit -text "Exit" -command { exit } -bg red -fg yellow -font {Helvetica 12 bold}

# Arrange the widgets in the window
pack .label .entry .submit .launch .show_secret .exit

# Start the Tk event loop
tkwait window .
