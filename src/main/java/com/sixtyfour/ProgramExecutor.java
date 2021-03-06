package com.sixtyfour;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.system.Cpu;
import com.sixtyfour.system.Machine;

/**
 * A common interface for implementations that are supposed to run programs.
 * This package contains an implementation for running BASIC V2 programs and one
 * for running 6502 assembler programs.
 * 
 * @author EgonOlsen
 */
public interface ProgramExecutor {

	/**
	 * Compiles a program.
	 * 
	 * @param config
	 */
	void compile(CompilerConfig config);

	/**
	 * Runs a program.
	 * 
	 * @param config
	 */
	void run(CompilerConfig config);

	/**
	 * Starts a program.
	 * 
	 * @param config
	 */
	void start(CompilerConfig config);

	/**
	 * Gets the machine.
	 * 
	 * @return the machine
	 */
	Machine getMachine();

	/**
	 * Gets the cpu.
	 * 
	 * @return the cpu
	 */
	Cpu getCpu();

	/**
	 * Gets the ram.
	 * 
	 * @return the ram
	 */
	int[] getRam();

	/**
	 * Stops execution after the next command.
	 */
	void runStop();

	/**
	 * Is the code running?
	 * 
	 * @return is it?
	 */

	boolean isRunning();
}
