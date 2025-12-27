
// AES-128 Encryption Algrothim 

module AES_Top (
    input  wire        clk,
    input  wire        reset_n,
    input  wire        enable,

    // ---- (4 words of 32 bits) of plaintext ----
    input  wire [31:0] plaintext0,  //000a
    input  wire [31:0] plaintext1,
    input  wire [31:0] plaintext2,
    input  wire [31:0] plaintext3,
    

    // ---- 15 bytes of key ----
    input  wire [7:0] key0,
    input  wire [7:0] key1,
    input  wire [7:0] key2,
    input  wire [7:0] key3,
    input  wire [7:0] key4,
    input  wire [7:0] key5,
    input  wire [7:0] key6,
    input  wire [7:0] key7,
    input  wire [7:0] key8,
    input  wire [7:0] key9,
    input  wire [7:0] key10,
    input  wire [7:0] key11,
    input  wire [7:0] key12,
    input  wire [7:0] key13,
    input  wire [7:0] key14,
	 input  wire [7:0] key15,

    // ---- Ciphertext output (4 words of 32 bits) ----
    output wire [31:0] ciphertext0,
    output wire [31:0] ciphertext1,
    output wire [31:0] ciphertext2,
    output wire [31:0] ciphertext3
);



wire [7:0] p0_b3 = plaintext0[31:24];
wire [7:0] p0_b2 = plaintext0[23:16];
wire [7:0] p0_b1 = plaintext0[15:8];
wire [7:0] p0_b0 = plaintext0[7:0];

wire [7:0] p1_b3 = plaintext1[31:24];
wire [7:0] p1_b2 = plaintext1[23:16];
wire [7:0] p1_b1 = plaintext1[15:8];
wire [7:0] p1_b0 = plaintext1[7:0];

wire [7:0] p2_b3 = plaintext2[31:24];
wire [7:0] p2_b2 = plaintext2[23:16];
wire [7:0] p2_b1 = plaintext2[15:8];
wire [7:0] p2_b0 = plaintext2[7:0];

wire [7:0] p3_b3 = plaintext3[31:24];
wire [7:0] p3_b2 = plaintext3[23:16];
wire [7:0] p3_b1 = plaintext3[15:8];
wire [7:0] p3_b0 = plaintext3[7:0];




//wire [127:0] plaintext128 = {
//    p0_b3, p0_b2, p0_b1, p0_b0,
//    p1_b3, p1_b2, p1_b1, p1_b0,
//    p2_b3, p2_b2, p2_b1, p2_b0,
//    p3_b3, p3_b2, p3_b1, p3_b0
//};



//wire [127:0] plaintext128 = {
//    p0_b0, p0_b1, p0_b2, p0_b3,
//    p1_b0, p1_b1, p1_b2, p1_b3,
//    p2_b0, p2_b1, p2_b2, p2_b3,
//    p3_b0, p3_b1, p3_b2, p3_b3
//};

wire [127:0] plaintext128 = {
    p0_b0, p1_b0, p2_b0, p3_b0,  // column 0
    p0_b1, p1_b1, p2_b1, p3_b1,  // column 1
    p0_b2, p1_b2, p2_b2, p3_b2,  // column 2
    p0_b3, p1_b3, p2_b3, p3_b3   // column 3
};
  

  // ----------------------------------------------------------------
    //  Assemble 15 bytes into 128-bit AES input (pad remaining byte)
    // ----------------------------------------------------------------
//   wire [127:0] plaintext128 = {
//    plaintext0, plaintext1, plaintext2, plaintext3
//    };
   // a3              -- a2           --- a1 ---a0 
     
	  
    wire [127:0] key128 = {
        key0,  key1,  key2,  key3,      // word 3
        key4,  key5,  key6,  key7,      // word 2
        key8,  key9,  key10, key11,     // word 1
        key12, key13, key14, key15      // word 0
    };
	 
	 
//	 wire [127:0] key128 = {
//    key0,  key4,  key8,  key12,
//    key1,  key5,  key9,  key13,
//    key2,  key6,  key10, key14,
//    key3,  key7,  key11, key15
//};
	 
	 // ===============================================================
    // 3) Enable edge-detect:
    //    - HPS writes 1 to the 'enable' PIO → rising edge
    //    - We generate a 1-cycle pulse 'aes_enable'
    //    - If HPS leaves enable=1, AES only sees the first edge
    //      (for a new run, HPS should write 0 then 1 again)
    // ===============================================================
    
	 
//	 reg enable_d;              // delayed copy of enable
//    wire aes_enable;           // 1-cycle pulse on rising edge of 'enable'
//
//    always @(posedge clk or negedge reset_n) begin
//        if (!reset_n)
//            enable_d <= 1'b0;
//        else
//            enable_d <= enable;
//    end
//
//    assign aes_enable = enable & ~enable_d;  // rising-edge detect
	

	 
    // ----------------------------------------------------------------
    //  AES encryption result
    // ----------------------------------------------------------------
    wire [127:0] ciphertext128;

    AES u_aes (
        .clk(clk),
        .reset_n(reset_n),
        .enable(enable),
        .in_conduit(plaintext128),
        .key_conduit(key128),
        .enc_conduit(ciphertext128)
    );

    // ----------------------------------------------------------------
    //  Split 128-bit ciphertext into 4 × 32-bit words
    // ----------------------------------------------------------------
    assign ciphertext0 = ciphertext128[127:96];
    assign ciphertext1 = ciphertext128[95:64];
    assign ciphertext2 = ciphertext128[63:32];
    assign ciphertext3 = ciphertext128[31:0];


endmodule
