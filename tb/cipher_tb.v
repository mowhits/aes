module tb;
    parameter Nk = 4; localparam Nkb = Nk*32; // 128 -> 4; 192 -> 6; 256 -> 8
    parameter Nr = 10; // 128 -> 10; 192 -> 12; 256 -> 14
    logic [0:Nkb - 1] key, in;
    logic [0:Nkb - 1] out;

    task display_out;
        integer i, j;
        begin
            $display("Out: ");
            for (i = 0; i < 4; i = i + 1) begin
                $write("%h ", out[32*i+:32]);
            end
        end
        $display("");
    endtask

    cipher c1(.in(in), .key(key), .out(out));

    initial begin
       in = 128'h0102030405060708090a0b0c0d0e0f00;
       key = 128'h0;
    end
endmodule