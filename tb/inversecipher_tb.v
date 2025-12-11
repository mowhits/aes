module inversecipher_tb;
    parameter Nk = 4; localparam Nkb = Nk*32; // 128 -> 4; 192 -> 6; 256 -> 8
    parameter Nr = 10; // 128 -> 10; 192 -> 12; 256 -> 14
    logic [0:Nkb - 1] key, in;
    logic [0:Nkb - 1] out;

    logic clk, rst_n;
    logic valid_in, valid_out;

    inversecipher dut (.in(in), .key(key), .out(out), .clk(clk), .rst_n(rst_n), .valid_in(valid_in), .valid_out(valid_out));

    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end

    initial begin
        $dumpfile("jump.vcd"); $dumpvars(0, inversecipher_tb);
        rst_n = 0;
        valid_in = 1;
        repeat(2) @(posedge clk);
        rst_n = 1;
        $monitor("t = %0t: %h", $time, out);
        // pipelined inputs here
        in = 128'h0a940bb5416ef045f1c39458c653ea5a; 
        key = 128'h00102030405060708090a0b0c0d0e0f;
        // plaintext = 128'h000102030405060708090a0b0c0d0e0f
        // repeat(2) @(posedge clk);
        @(posedge clk);
        in = 128'h20a9f992b44c5be8041ffcdc6cae996a;
        key = 128'h000102030405060708090a0b0c0d0e0f;
        // plaintext = 128'h0f0e0d0c0b0a09080706050403020100
        @(posedge clk);
        in = 128'hb7ea90af536c82a8c8df97106b978f5a;
        key = 128'h000102030405060708090a0b0c0d0e0f;
        // plaintext = 128'h00000101030307070f0f1f1f3f3f7f7f
        #50 rst_n = 0;
        repeat(2) @(posedge clk); rst_n = 1;
        in = 128'h20a9f992b44c5be8041ffcdc6cae996a;
        key = 128'h000102030405060708090a0b0c0d0e0f;
        // plaintext = 128'h0f0e0d0c0b0a09080706050403020100
        @(posedge clk);
        in = 128'h0a940bb5416ef045f1c39458c653ea5a; 
        key = 128'h00102030405060708090a0b0c0d0e0f;
        // plaintext = 128'h000102030405060708090a0b0c0d0e0f
        @(posedge clk);
        #30 $finish;
    end
endmodule