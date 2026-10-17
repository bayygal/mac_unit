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

reg signed [31:0] expected;
integer errors = 0;

task step(input r, input e, input signed [7:0] x, input signed [7:0] y);
begin
    // 1. drive rst, en, a, b from r, e, x, y
    rst = r;
    en = e;
    a = x;
    b = y;

    // 2. @(posedge clk); #1;
    @(posedge clk); #1;

    // 3. update expected
    if (r) begin
        expected = 0;
    end else if (e) begin
        expected = expected + x * y;
    end

    // 4. compare expected against acc; if they differ, print and bump errors
    if (expected !== acc) begin
        $display("acc = %0d \n expected = %0d", acc, expected);
        errors += 1;
    end
end
endtask

initial begin
    step(1, 0, 0, 0);
    step(0, 1, 3, 4);
    step(0, 0, 5, 5);
    step(0, 1, 2, 2);
    $display("errors = %0d", errors);
    $finish;
end

endmodule