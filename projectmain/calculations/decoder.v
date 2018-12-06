module decoder (
    din,
    select
);

	input [4:0] din;
	
	output [31:0] select;

	wire ndin0,ndin1,ndin2,ndin3,ndin4;
	
	not not0(ndin0,din[0]);
	not not1(ndin1,din[1]);
	not not2(ndin2,din[2]);
	not not3(ndin3,din[3]);
	not not4(ndin4,din[4]);
	
	and and0(select[0],ndin0,ndin1,ndin2,ndin3,ndin4);
	and and1(select[1],din[0],ndin1,ndin2,ndin3,ndin4);
	and and2(select[2],ndin0,din[1],ndin2,ndin3,ndin4);
	and and3(select[3],din[0],din[1],ndin2,ndin3,ndin4);
	and and4(select[4],ndin0,ndin1,din[2],ndin3,ndin4);
	and and5(select[5],din[0],ndin1,din[2],ndin3,ndin4);
	and and6(select[6],ndin0,din[1],din[2],ndin3,ndin4);
	and and7(select[7],din[0],din[1],din[2],ndin3,ndin4);
	and and8(select[8],ndin0,ndin1,ndin2,din[3],ndin4);
	and and9(select[9],din[0],ndin1,ndin2,din[3],ndin4);
	and and10(select[10],ndin0,din[1],ndin2,din[3],ndin4);
	and and11(select[11],din[0],din[1],ndin2,din[3],ndin4);
	and and12(select[12],ndin0,ndin1,din[2],din[3],ndin4);
	and and13(select[13],din[0],ndin1,din[2],din[3],ndin4);
	and and14(select[14],ndin0,din[1],din[2],din[3],ndin4);
	and and15(select[15],din[0],din[1],din[2],din[3],ndin4);
	and and16(select[16],ndin0,ndin1,ndin2,ndin3,din[4]);
	and and17(select[17],din[0],ndin1,ndin2,ndin3,din[4]);
	and and18(select[18],ndin0,din[1],ndin2,ndin3,din[4]);
	and and19(select[19],din[0],din[1],ndin2,ndin3,din[4]);
	and and20(select[20],ndin0,ndin1,din[2],ndin3,din[4]);
	and and21(select[21],din[0],ndin1,din[2],ndin3,din[4]);
	and and22(select[22],ndin0,din[1],din[2],ndin3,din[4]);
	and and23(select[23],din[0],din[1],din[2],ndin3,din[4]);
	and and24(select[24],ndin0,ndin1,ndin2,din[3],din[4]);
	and and25(select[25],din[0],ndin1,ndin2,din[3],din[4]);
	and and26(select[26],ndin0,din[1],ndin2,din[3],din[4]);
	and and27(select[27],din[0],din[1],ndin2,din[3],din[4]);
	and and28(select[28],ndin0,ndin1,din[2],din[3],din[4]);
	and and29(select[29],din[0],ndin1,din[2],din[3],din[4]);
	and and30(select[30],ndin0,din[1],din[2],din[3],din[4]);
	and and31(select[31],din[0],din[1],din[2],din[3],din[4]);

endmodule
