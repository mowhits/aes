module tb;
    parameter Nk = 4; localparam Nkb = Nk*32; // 128 -> 4; 192 -> 6; 256 -> 8
    parameter Nr = 10; // 128 -> 10; 192 -> 12; 256 -> 14
    logic [0:Nkb - 1] key;
    logic [32*(4*Nr + 4) - 1:0] w;;

    task display_round_keys;
        integer i, j;
        begin
            $display("\n=== Round Keys ===");
            for (i = 0; i <= Nr; i = i + 1) begin
                $display("Round %0d:", i);
                $write("w = ");
                for (j = 0; j < 4; j = j + 1) begin
                    $write("%h ", w[128*i + 32*j +:32]); 
                end
                $display("");
            end
        end
    endtask

    keyexpansion uut(.key(key), .w(w));

    initial begin
        key = 128'h000102030405060708090a0b0c0d0e0f;
        #10 display_round_keys();
    end

endmodule