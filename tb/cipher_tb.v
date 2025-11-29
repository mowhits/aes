module cipher_tb;
    parameter Nk = 4; localparam Nkb = Nk*32; // 128 -> 4; 192 -> 6; 256 -> 8
    parameter Nr = 10; // 128 -> 10; 192 -> 12; 256 -> 14
    logic [0:Nkb - 1] key, in;
    logic [0:Nkb - 1] out;
    logic clk, rst_n;

    cipher dut (.in(in), .key(key), .out(out), .clk(clk), .rst_n(rst_n));

    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end

    initial begin
        // $dumpfile("dump.vcd"); $dumpvars(0, cipher_tb, dut.state[0], dut.state[1], dut.state[2], dut.state[3], dut.state[4], dut.state[5], dut.state[6], dut.state[7], dut.state[8], dut.state[9], dut.state[10], dut.state[11]);
        rst_n = 0;
        #2
        rst_n = 1;
        in = 128'h000102030405060708090a0b0c0d0e0f;
        key = 128'h00102030405060708090a0b0c0d0e0f;
        #1 key = 128'h000102030405060708090a0b0c0d0e0f;
        in = 128'h0;

        wait(out == 128'h0a940bb5416ef045f1c39458c653ea5a);
        $display("plaintext = %h\nkey = %h\nciphertext = %h", in, key, out);
        if (out == 128'h0a940bb5416ef045f1c39458c653ea5a) $display("The ciphertext is correct.");
        else $display("The ciphertext is incorrect. Expected: 128'h0a940bb5416ef045f1c39458c653ea5a");
        wait(out == 128'hc6a13b37878f5b826f4f8162a1c8d879);
        $display("plaintext = %h\nkey = %h\nciphertext = %h\n", in, key, out);
        if (out == 128'hc6a13b37878f5b826f4f8162a1c8d879) $display("The ciphertext is correct.");
        else $display("The ciphertext is incorrect. Expected: 128'h7aca0fd9bcd6ec7c9f97466616e6a282");
        $finish;
    end
endmodule