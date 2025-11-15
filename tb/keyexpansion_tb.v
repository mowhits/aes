module tb;
    parameter Nk = 4; localparam Nkb = Nk*32; // 128 -> 4; 192 -> 6; 256 -> 8
    parameter Nr = 10; // 128 -> 10; 192 -> 12; 256 -> 14
    logic [0:Nkb - 1] key;
    logic [0:32*(4*Nr + 4) - 1] w;

    task display_round_keys;
        integer i, j;
        begin
            for (i = 0; i <= Nr; i = i + 1) begin
                $display("Round %0d: w = %h", i,  w[128*i+:128]);
            end
        end
    endtask

    keyexpansion uut(.key(key), .w(w));

    initial begin
        key = 128'h000102030405060708090a0b0c0d0e0f;
        #10 display_round_keys();
        $display("");
        key = 128'h0;
        #10 display_round_keys();
    end

endmodule