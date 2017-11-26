#! /bin/env tclsh

puts {tcl:: start}

puts {tcl:: compiling and running: go run fpgo.go}
exec >&@stdout go run fpgo.go

puts {tcl:: compiling fpgo.v:      iverilog -o fpgo fpgo.v}
exec >&@stdout iverilog -o fpgo fpgo.v

puts {tcl:: running fpgo:          vpp fpgo}
exec >&@stdout vvp fpgo

puts {tcl:: archiving tar -cf misc/fpgo.zip fpgo*}
exec >&@stdout tar -cf misc/fpgo.zip fpgo*
	
puts {tcl:: done}
