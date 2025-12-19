module cipher_tb;
    parameter Nk = 4; localparam Nkb = Nk*32; // 128 -> 4; 192 -> 6; 256 -> 8
    parameter Nr = 10; // 128 -> 10; 192 -> 12; 256 -> 14
    logic [0:Nkb - 1] key;
    logic [0:127] in;
    logic [0:127] out;

    logic clk, rst_n;
    logic valid_in, valid_out;

    cipher dut (.in(in), .key(key), .out(out), .clk(clk), .rst_n(rst_n), .valid_in(valid_in), .valid_out(valid_out));

    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end

    always @(posedge clk) begin
        integer i;
        i <= 0;
        $monitor("t = %0t / cycle %0d: %h, valid_out: %b", $time, i, out, valid_out);
        i <= i + 1;
    end

    initial begin
        $dumpfile("dump.vcd"); $dumpvars(0, cipher_tb);
        rst_n = 0;
        valid_in = 1;
        $display("RESET");
        repeat(2) @(posedge clk);
        rst_n = 1;
        key = 128'h00102030405060708090a0b0c0d0e0f;

        repeat(2) @(posedge clk);
        in = 128'h000102030405060708090a0b0c0d0e0f;
        // ciphertext : 128'h0a940bb5416ef045f1c39458c653ea5a
        @(posedge clk);
        in = 128'h0f0e0d0c0b0a09080706050403020100;
        // ciphertext : 128'h20a9f992b44c5be8041ffcdc6cae996a
        @(posedge clk);
        in = 128'h00000101030307070f0f1f1f3f3f7f7f;
        // ciphertext : 128'hb7ea90af536c82a8c8df97106b978f5a
        @(posedge clk);
        in = 128'h0;
        // ciphertext : 128'hc6a13b37878f5b826f4f8162a1c8d879
        @(posedge clk);
        in = 128'h0f0e0d0c0b0a09080706050403020100;
        // ciphertext : 128'h20a9f992b44c5be8041ffcdc6cae996a
        @(posedge clk);
        in = 128'h000102030405060708090a0b0c0d0e0f;
        // ciphertext : 128'h0a940bb5416ef045f1c39458c653ea5a
        @(posedge clk);
        in = 128'h0;
        // ciphertext : 128'hc6a13b37878f5b826f4f8162a1c8d879
        
        #30 rst_n = 0; // waiting for pipeline to process
        $display("RESET");
        repeat(2) @(posedge clk);
        rst_n = 1;
        key = 128'h00102030405060708090a0b0c0d0e0f;

        repeat(2) @(posedge clk);
        in = 128'h000102030405060708090a0b0c0d0e0f;
        // ciphertext : 128'h0a940bb5416ef045f1c39458c653ea5a
        @(posedge clk);
        in = 128'h0f0e0d0c0b0a09080706050403020100;
        // ciphertext : 128'h20a9f992b44c5be8041ffcdc6cae996a
        @(posedge clk);
        in = 128'h00000101030307070f0f1f1f3f3f7f7f;
        // ciphertext : 128'hb7ea90af536c82a8c8df97106b978f5a
        @(posedge clk);
        in = 128'h000102030405060708090a0b0c0d0e0f;
        // ciphertext : 128'h0a940bb5416ef045f1c39458c653ea5a
        @(posedge clk);
        in = 128'h0;
        // ciphertext : 128'hc6a13b37878f5b826f4f8162a1c8d879
        
        #30 $finish;
    end
endmodule