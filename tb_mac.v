module tb_mac;
    reg clk, rst, en;
    reg signed [7:0] a, b;
    wire signed [31:0] acc;

    mac uut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .a(a),
        .b(b),
        .acc(acc)
    );

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
   rst = 1; en = 0; a = 0; b = 0;
   @(posedge clk); #1;
   $display("acc = %d (expected 12)", acc);

    rst = 0; en = 1; a = 3; b = 4;
   @(posedge clk); #1;          // acc = 0 + 3*4 = 12

   en = 0;
   $display("acc = %d (expected 12)", acc);

   $finish; 
end

endmodule