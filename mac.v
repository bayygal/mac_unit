module mac (clk, rst, en, a, b, acc);
input clk, rst, en;
input signed [7:0] a, b;
output reg signed [31:0] acc;

always @(posedge clk) begin
    if (rst) begin
        acc <= 0;
    end else if (en) begin
        acc <= acc + a * b;
    end
end

endmodule