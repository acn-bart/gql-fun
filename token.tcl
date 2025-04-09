#!/usr/bin/env wish

# Create the main window
wm title . "Secret Input"

# Create a label and an entry widget for the secret input
label .label -text "Enter your secret:"
entry .entry -show "*" -textvariable secret

# Create a button to submit the input
button .submit -text "Submit" -command {
    set secret_value $secret
    set file [open "foo" "w"]
    puts $file $secret_value
    close $file
    tk_messageBox -message "Input has been written to the file 'foo'."
}

# Arrange the widgets in the window
pack .label .entry .submit

# Start the Tk event loop
tkwait window .
