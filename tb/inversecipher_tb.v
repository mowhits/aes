module inversecipher_tb;
    parameter Nk = 4; localparam Nkb = Nk*32; // 128 -> 4; 192 -> 6; 256 -> 8
    parameter Nr = 10; // 128 -> 10; 192 -> 12; 256 -> 14
    logic [0:Nkb - 1] key, in;
    logic [0:Nkb - 1] out;

    inversecipher dut (.in(in), .key(key), .out(out));

    initial begin
        $dumpfile("dump.vcd"); $dumpvars(0, inversecipher_tb);

        in = 128'h0a940bb5416ef045f1c39458c653ea5a;
        key = 128'h00102030405060708090a0b0c0d0e0f;

        #10 $display("ciphertext = %h\nkey = %h\ndeciphered plaintext = %h", in, key, out);
        if (out == 128'h000102030405060708090a0b0c0d0e0f) $display("The deciphered plaintext is correct.");
        else $display("The deciphered plaintext is incorrect. Expected: 000102030405060708090a0b0c0d0e0f");

        in = 128'h7aca0fd9bcd6ec7c9f97466616e6a282;
        key = 128'h0;

        #10 $display("ciphertext = %h\nkey = %h\ndeciphered plaintext = %h", in, key, out);
        if (out == 128'h000102030405060708090a0b0c0d0e0f) $display("The deciphered plaintext is correct.");
        else $display("The deciphered plaintext is incorrect.");
    end
endmodule