module AES (
    input  wire        clk,          // for future use / timing
    input  wire        reset_n,      // for future use / timing
    input  wire        enable,       // control from HPS or FPGA
    input  wire [127:0] in_conduit,  // plaintext  conduit  (from HPS side)
    input  wire [127:0] key_conduit, // key        conduit  (from HPS side)
    output wire [127:0] enc_conduit  // ciphertext conduit  (to HPS side)
);

    // Internal wire for AES result
    wire [127:0] encrypted128;

    // Core AES encryption block
    AES_Encrypt u_aes (
        .in  (in_conduit),
        .key (key_conduit),
        .out (encrypted128)
    );

    // Only drive enc_conduit when enable = 1
    // (otherwise drive zeros; easier for FPGA than tri-state)
    assign enc_conduit = enable ? encrypted128 : 128'b0;

endmodule
