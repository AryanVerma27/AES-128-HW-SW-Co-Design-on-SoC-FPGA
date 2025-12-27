`timescale 1ns/1ps

module tb_AES_Encrypt;

  // Testbench signals to drive the DUT
  reg  [127:0] plaintext;
  reg  [127:0] key128;
  wire [127:0] encrypted128;

  // Expected ciphertext for the test vector (from FIPS-197)
  reg  [127:0] expected128;

  // Instantiate the DUT (AES_Encrypt)
  // Positional port mapping: (plaintext, key, ciphertext)
  AES_Encrypt dut (
    plaintext,
    key128,
    encrypted128
  );

  initial begin
    // Test 1: Known AES-128 test vector
    // Plaintext  = 00112233445566778899aabbccddeeff
    // Key        = 000102030405060708090a0b0c0d0e0f
    // Ciphertext = 69c4e0d86a7b0430d8cdb78070b4c55a
    plaintext   = 128'h00112233445566778899aabbccddeeff;
    key128      = 128'h000102030405060708090a0b0c0d0e0f;
    expected128 = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;

    // Wait some time for combinational logic / small latency
    // (If your AES is fully combinational, #10 is enough;
    // if it is pipelined/clocked, you need to add clock + wait N cycles.)
    #10;

    $display("Test 1:");
    $display("Plaintext : %h", plaintext);
    $display("Key       : %h", key128);
    $display("Output    : %h", encrypted128);
    $display("Expected  : %h", expected128);

    if (encrypted128 === expected128)
      $display("RESULT: PASS");
    else
      $display("RESULT: FAIL");

    // You can add more tests here:
    // Test 2: change plaintext or key
    plaintext   = 128'h00112233445566778899aabbccddeeff; // example
    key128      = 128'h0f0e0d0c0b0a09080706050403020100; // example
    expected128 = 128'hXXXXXXXX_XXXXXXXX_XXXXXXXX_XXXXXXXX; // put correct cipher if you know it

    #10;

    $display("Test 2:");
    $display("Plaintext : %h", plaintext);
    $display("Key       : %h", key128);
    $display("Output    : %h", encrypted128);
    $display("Expected  : %h", expected128);

    if (encrypted128 === expected128)
      $display("RESULT: PASS");
    else
      $display("RESULT: FAIL (expected updated value here)");

    // Finish simulation
    #10;
    $finish;
  end

endmodule
