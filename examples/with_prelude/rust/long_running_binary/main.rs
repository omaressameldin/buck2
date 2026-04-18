/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is dual-licensed under either the MIT license found in the
 * LICENSE-MIT file in the root directory of this source tree or the Apache
 * License, Version 2.0 found in the LICENSE-APACHE file in the root directory
 * of this source tree. You may select, at your option, one of the
 * above-listed licenses.
 */

use std::fs;
use std::thread;
use std::time::Duration;
use std::path::Path;
use std::env;


fn main() {
    let args: Vec<String> = env::args().collect(); 
    let data = "Some data!";
    println!("Writing to file: {}", args[1]);
    thread::sleep(Duration::from_millis(40000));
    println!("Done sleeping");
    fs::write(Path::new(&args[1]), data).expect("Should be able to write to `output_file`");
}
