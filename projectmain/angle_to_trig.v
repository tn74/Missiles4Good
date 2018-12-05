module angle_to_trig (angle, sin, cos);
	input[8:0] angle;
	output reg[31:0] sin;
	output reg[31:0] cos;
	
	always @(angle)
	begin
		if (angle == 8'd0)
			begin
			sin = 32'd1000;
			cos = 32'd0;
			end
		else if (angle == 8'd1)
			begin
			sin = 32'd1000;
			cos = 32'd17;
			end
		else if (angle == 8'd2)
			begin
			sin = 32'd999;
			cos = 32'd35;
			end
		else if (angle == 8'd3)
			begin
			sin = 32'd999;
			cos = 32'd52;
			end
		else if (angle == 8'd4)
			begin
			sin = 32'd998;
			cos = 32'd70;
			end
		else if (angle == 8'd5)
			begin
			sin = 32'd996;
			cos = 32'd87;
			end
		else if (angle == 8'd6)
			begin
			sin = 32'd995;
			cos = 32'd105;
			end
		else if (angle == 8'd7)
			begin
			sin = 32'd993;
			cos = 32'd122;
			end
		else if (angle == 8'd8)
			begin
			sin = 32'd990;
			cos = 32'd139;
			end
		else if (angle == 8'd9)
			begin
			sin = 32'd988;
			cos = 32'd156;
			end
		else if (angle == 8'd10)
			begin
			sin = 32'd985;
			cos = 32'd174;
			end
		else if (angle == 8'd11)
			begin
			sin = 32'd982;
			cos = 32'd191;
			end
		else if (angle == 8'd12)
			begin
			sin = 32'd978;
			cos = 32'd208;
			end
		else if (angle == 8'd13)
			begin
			sin = 32'd974;
			cos = 32'd225;
			end
		else if (angle == 8'd14)
			begin
			sin = 32'd970;
			cos = 32'd242;
			end
		else if (angle == 8'd15)
			begin
			sin = 32'd966;
			cos = 32'd259;
			end
		else if (angle == 8'd16)
			begin
			sin = 32'd961;
			cos = 32'd276;
			end
		else if (angle == 8'd17)
			begin
			sin = 32'd956;
			cos = 32'd292;
			end
		else if (angle == 8'd18)
			begin
			sin = 32'd951;
			cos = 32'd309;
			end
		else if (angle == 8'd19)
			begin
			sin = 32'd946;
			cos = 32'd326;
			end
		else if (angle == 8'd20)
			begin
			sin = 32'd940;
			cos = 32'd342;
			end
		else if (angle == 8'd21)
			begin
			sin = 32'd934;
			cos = 32'd358;
			end
		else if (angle == 8'd22)
			begin
			sin = 32'd927;
			cos = 32'd375;
			end
		else if (angle == 8'd23)
			begin
			sin = 32'd921;
			cos = 32'd391;
			end
		else if (angle == 8'd24)
			begin
			sin = 32'd914;
			cos = 32'd407;
			end
		else if (angle == 8'd25)
			begin
			sin = 32'd906;
			cos = 32'd423;
			end
		else if (angle == 8'd26)
			begin
			sin = 32'd899;
			cos = 32'd438;
			end
		else if (angle == 8'd27)
			begin
			sin = 32'd891;
			cos = 32'd454;
			end
		else if (angle == 8'd28)
			begin
			sin = 32'd883;
			cos = 32'd469;
			end
		else if (angle == 8'd29)
			begin
			sin = 32'd875;
			cos = 32'd485;
			end
		else if (angle == 8'd30)
			begin
			sin = 32'd866;
			cos = 32'd500;
			end
		else if (angle == 8'd31)
			begin
			sin = 32'd857;
			cos = 32'd515;
			end
		else if (angle == 8'd32)
			begin
			sin = 32'd848;
			cos = 32'd530;
			end
		else if (angle == 8'd33)
			begin
			sin = 32'd839;
			cos = 32'd545;
			end
		else if (angle == 8'd34)
			begin
			sin = 32'd829;
			cos = 32'd559;
			end
		else if (angle == 8'd35)
			begin
			sin = 32'd819;
			cos = 32'd574;
			end
		else if (angle == 8'd36)
			begin
			sin = 32'd809;
			cos = 32'd588;
			end
		else if (angle == 8'd37)
			begin
			sin = 32'd799;
			cos = 32'd602;
			end
		else if (angle == 8'd38)
			begin
			sin = 32'd788;
			cos = 32'd616;
			end
		else if (angle == 8'd39)
			begin
			sin = 32'd777;
			cos = 32'd629;
			end
		else if (angle == 8'd40)
			begin
			sin = 32'd766;
			cos = 32'd643;
			end
		else if (angle == 8'd41)
			begin
			sin = 32'd755;
			cos = 32'd656;
			end
		else if (angle == 8'd42)
			begin
			sin = 32'd743;
			cos = 32'd669;
			end
		else if (angle == 8'd43)
			begin
			sin = 32'd731;
			cos = 32'd682;
			end
		else if (angle == 8'd44)
			begin
			sin = 32'd719;
			cos = 32'd695;
			end
		else if (angle == 8'd45)
			begin
			sin = 32'd707;
			cos = 32'd707;
			end
		else if (angle == 8'd46)
			begin
			sin = 32'd695;
			cos = 32'd719;
			end
		else if (angle == 8'd47)
			begin
			sin = 32'd682;
			cos = 32'd731;
			end
		else if (angle == 8'd48)
			begin
			sin = 32'd669;
			cos = 32'd743;
			end
		else if (angle == 8'd49)
			begin
			sin = 32'd656;
			cos = 32'd755;
			end
		else if (angle == 8'd50)
			begin
			sin = 32'd643;
			cos = 32'd766;
			end
		else if (angle == 8'd51)
			begin
			sin = 32'd629;
			cos = 32'd777;
			end
		else if (angle == 8'd52)
			begin
			sin = 32'd616;
			cos = 32'd788;
			end
		else if (angle == 8'd53)
			begin
			sin = 32'd602;
			cos = 32'd799;
			end
		else if (angle == 8'd54)
			begin
			sin = 32'd588;
			cos = 32'd809;
			end
		else if (angle == 8'd55)
			begin
			sin = 32'd574;
			cos = 32'd819;
			end
		else if (angle == 8'd56)
			begin
			sin = 32'd559;
			cos = 32'd829;
			end
		else if (angle == 8'd57)
			begin
			sin = 32'd545;
			cos = 32'd839;
			end
		else if (angle == 8'd58)
			begin
			sin = 32'd530;
			cos = 32'd848;
			end
		else if (angle == 8'd59)
			begin
			sin = 32'd515;
			cos = 32'd857;
			end
		else if (angle == 8'd60)
			begin
			sin = 32'd500;
			cos = 32'd866;
			end
		else if (angle == 8'd61)
			begin
			sin = 32'd485;
			cos = 32'd875;
			end
		else if (angle == 8'd62)
			begin
			sin = 32'd469;
			cos = 32'd883;
			end
		else if (angle == 8'd63)
			begin
			sin = 32'd454;
			cos = 32'd891;
			end
		else if (angle == 8'd64)
			begin
			sin = 32'd438;
			cos = 32'd899;
			end
		else if (angle == 8'd65)
			begin
			sin = 32'd423;
			cos = 32'd906;
			end
		else if (angle == 8'd66)
			begin
			sin = 32'd407;
			cos = 32'd914;
			end
		else if (angle == 8'd67)
			begin
			sin = 32'd391;
			cos = 32'd921;
			end
		else if (angle == 8'd68)
			begin
			sin = 32'd375;
			cos = 32'd927;
			end
		else if (angle == 8'd69)
			begin
			sin = 32'd358;
			cos = 32'd934;
			end
		else if (angle == 8'd70)
			begin
			sin = 32'd342;
			cos = 32'd940;
			end
		else if (angle == 8'd71)
			begin
			sin = 32'd326;
			cos = 32'd946;
			end
		else if (angle == 8'd72)
			begin
			sin = 32'd309;
			cos = 32'd951;
			end
		else if (angle == 8'd73)
			begin
			sin = 32'd292;
			cos = 32'd956;
			end
		else if (angle == 8'd74)
			begin
			sin = 32'd276;
			cos = 32'd961;
			end
		else if (angle == 8'd75)
			begin
			sin = 32'd259;
			cos = 32'd966;
			end
		else if (angle == 8'd76)
			begin
			sin = 32'd242;
			cos = 32'd970;
			end
		else if (angle == 8'd77)
			begin
			sin = 32'd225;
			cos = 32'd974;
			end
		else if (angle == 8'd78)
			begin
			sin = 32'd208;
			cos = 32'd978;
			end
		else if (angle == 8'd79)
			begin
			sin = 32'd191;
			cos = 32'd982;
			end
		else if (angle == 8'd80)
			begin
			sin = 32'd174;
			cos = 32'd985;
			end
		else if (angle == 8'd81)
			begin
			sin = 32'd156;
			cos = 32'd988;
			end
		else if (angle == 8'd82)
			begin
			sin = 32'd139;
			cos = 32'd990;
			end
		else if (angle == 8'd83)
			begin
			sin = 32'd122;
			cos = 32'd993;
			end
		else if (angle == 8'd84)
			begin
			sin = 32'd105;
			cos = 32'd995;
			end
		else if (angle == 8'd85)
			begin
			sin = 32'd87;
			cos = 32'd996;
			end
		else if (angle == 8'd86)
			begin
			sin = 32'd70;
			cos = 32'd998;
			end
		else if (angle == 8'd87)
			begin
			sin = 32'd52;
			cos = 32'd999;
			end
		else if (angle == 8'd88)
			begin
			sin = 32'd35;
			cos = 32'd999;
			end
		else if (angle == 8'd89)
			begin
			sin = 32'd17;
			cos = 32'd1000;
			end
		else if (angle == 8'd90)
			begin
			sin = 32'd0;
			cos = 32'd1000;
			end
		else if (angle == 8'd91)
			begin
			sin = -32'd17;
			cos = 32'd1000;
			end
		else if (angle == 8'd92)
			begin
			sin = -32'd35;
			cos = 32'd999;
			end
		else if (angle == 8'd93)
			begin
			sin = -32'd52;
			cos = 32'd999;
			end
		else if (angle == 8'd94)
			begin
			sin = -32'd70;
			cos = 32'd998;
			end
		else if (angle == 8'd95)
			begin
			sin = -32'd87;
			cos = 32'd996;
			end
		else if (angle == 8'd96)
			begin
			sin = -32'd105;
			cos = 32'd995;
			end
		else if (angle == 8'd97)
			begin
			sin = -32'd122;
			cos = 32'd993;
			end
		else if (angle == 8'd98)
			begin
			sin = -32'd139;
			cos = 32'd990;
			end
		else if (angle == 8'd99)
			begin
			sin = -32'd156;
			cos = 32'd988;
			end
		else if (angle == 8'd100)
			begin
			sin = -32'd174;
			cos = 32'd985;
			end
		else if (angle == 8'd101)
			begin
			sin = -32'd191;
			cos = 32'd982;
			end
		else if (angle == 8'd102)
			begin
			sin = -32'd208;
			cos = 32'd978;
			end
		else if (angle == 8'd103)
			begin
			sin = -32'd225;
			cos = 32'd974;
			end
		else if (angle == 8'd104)
			begin
			sin = -32'd242;
			cos = 32'd970;
			end
		else if (angle == 8'd105)
			begin
			sin = -32'd259;
			cos = 32'd966;
			end
		else if (angle == 8'd106)
			begin
			sin = -32'd276;
			cos = 32'd961;
			end
		else if (angle == 8'd107)
			begin
			sin = -32'd292;
			cos = 32'd956;
			end
		else if (angle == 8'd108)
			begin
			sin = -32'd309;
			cos = 32'd951;
			end
		else if (angle == 8'd109)
			begin
			sin = -32'd326;
			cos = 32'd946;
			end
		else if (angle == 8'd110)
			begin
			sin = -32'd342;
			cos = 32'd940;
			end
		else if (angle == 8'd111)
			begin
			sin = -32'd358;
			cos = 32'd934;
			end
		else if (angle == 8'd112)
			begin
			sin = -32'd375;
			cos = 32'd927;
			end
		else if (angle == 8'd113)
			begin
			sin = -32'd391;
			cos = 32'd921;
			end
		else if (angle == 8'd114)
			begin
			sin = -32'd407;
			cos = 32'd914;
			end
		else if (angle == 8'd115)
			begin
			sin = -32'd423;
			cos = 32'd906;
			end
		else if (angle == 8'd116)
			begin
			sin = -32'd438;
			cos = 32'd899;
			end
		else if (angle == 8'd117)
			begin
			sin = -32'd454;
			cos = 32'd891;
			end
		else if (angle == 8'd118)
			begin
			sin = -32'd469;
			cos = 32'd883;
			end
		else if (angle == 8'd119)
			begin
			sin = -32'd485;
			cos = 32'd875;
			end
		else if (angle == 8'd120)
			begin
			sin = -32'd500;
			cos = 32'd866;
			end
		else if (angle == 8'd121)
			begin
			sin = -32'd515;
			cos = 32'd857;
			end
		else if (angle == 8'd122)
			begin
			sin = -32'd530;
			cos = 32'd848;
			end
		else if (angle == 8'd123)
			begin
			sin = -32'd545;
			cos = 32'd839;
			end
		else if (angle == 8'd124)
			begin
			sin = -32'd559;
			cos = 32'd829;
			end
		else if (angle == 8'd125)
			begin
			sin = -32'd574;
			cos = 32'd819;
			end
		else if (angle == 8'd126)
			begin
			sin = -32'd588;
			cos = 32'd809;
			end
		else if (angle == 8'd127)
			begin
			sin = -32'd602;
			cos = 32'd799;
			end
		else if (angle == 8'd128)
			begin
			sin = -32'd616;
			cos = 32'd788;
			end
		else if (angle == 8'd129)
			begin
			sin = -32'd629;
			cos = 32'd777;
			end
		else if (angle == 8'd130)
			begin
			sin = -32'd643;
			cos = 32'd766;
			end
		else if (angle == 8'd131)
			begin
			sin = -32'd656;
			cos = 32'd755;
			end
		else if (angle == 8'd132)
			begin
			sin = -32'd669;
			cos = 32'd743;
			end
		else if (angle == 8'd133)
			begin
			sin = -32'd682;
			cos = 32'd731;
			end
		else if (angle == 8'd134)
			begin
			sin = -32'd695;
			cos = 32'd719;
			end
		else if (angle == 8'd135)
			begin
			sin = -32'd707;
			cos = 32'd707;
			end
		else if (angle == 8'd136)
			begin
			sin = -32'd719;
			cos = 32'd695;
			end
		else if (angle == 8'd137)
			begin
			sin = -32'd731;
			cos = 32'd682;
			end
		else if (angle == 8'd138)
			begin
			sin = -32'd743;
			cos = 32'd669;
			end
		else if (angle == 8'd139)
			begin
			sin = -32'd755;
			cos = 32'd656;
			end
		else if (angle == 8'd140)
			begin
			sin = -32'd766;
			cos = 32'd643;
			end
		else if (angle == 8'd141)
			begin
			sin = -32'd777;
			cos = 32'd629;
			end
		else if (angle == 8'd142)
			begin
			sin = -32'd788;
			cos = 32'd616;
			end
		else if (angle == 8'd143)
			begin
			sin = -32'd799;
			cos = 32'd602;
			end
		else if (angle == 8'd144)
			begin
			sin = -32'd809;
			cos = 32'd588;
			end
		else if (angle == 8'd145)
			begin
			sin = -32'd819;
			cos = 32'd574;
			end
		else if (angle == 8'd146)
			begin
			sin = -32'd829;
			cos = 32'd559;
			end
		else if (angle == 8'd147)
			begin
			sin = -32'd839;
			cos = 32'd545;
			end
		else if (angle == 8'd148)
			begin
			sin = -32'd848;
			cos = 32'd530;
			end
		else if (angle == 8'd149)
			begin
			sin = -32'd857;
			cos = 32'd515;
			end
		else if (angle == 8'd150)
			begin
			sin = -32'd866;
			cos = 32'd500;
			end
		else if (angle == 8'd151)
			begin
			sin = -32'd875;
			cos = 32'd485;
			end
		else if (angle == 8'd152)
			begin
			sin = -32'd883;
			cos = 32'd469;
			end
		else if (angle == 8'd153)
			begin
			sin = -32'd891;
			cos = 32'd454;
			end
		else if (angle == 8'd154)
			begin
			sin = -32'd899;
			cos = 32'd438;
			end
		else if (angle == 8'd155)
			begin
			sin = -32'd906;
			cos = 32'd423;
			end
		else if (angle == 8'd156)
			begin
			sin = -32'd914;
			cos = 32'd407;
			end
		else if (angle == 8'd157)
			begin
			sin = -32'd921;
			cos = 32'd391;
			end
		else if (angle == 8'd158)
			begin
			sin = -32'd927;
			cos = 32'd375;
			end
		else if (angle == 8'd159)
			begin
			sin = -32'd934;
			cos = 32'd358;
			end
		else if (angle == 8'd160)
			begin
			sin = -32'd940;
			cos = 32'd342;
			end
		else if (angle == 8'd161)
			begin
			sin = -32'd946;
			cos = 32'd326;
			end
		else if (angle == 8'd162)
			begin
			sin = -32'd951;
			cos = 32'd309;
			end
		else if (angle == 8'd163)
			begin
			sin = -32'd956;
			cos = 32'd292;
			end
		else if (angle == 8'd164)
			begin
			sin = -32'd961;
			cos = 32'd276;
			end
		else if (angle == 8'd165)
			begin
			sin = -32'd966;
			cos = 32'd259;
			end
		else if (angle == 8'd166)
			begin
			sin = -32'd970;
			cos = 32'd242;
			end
		else if (angle == 8'd167)
			begin
			sin = -32'd974;
			cos = 32'd225;
			end
		else if (angle == 8'd168)
			begin
			sin = -32'd978;
			cos = 32'd208;
			end
		else if (angle == 8'd169)
			begin
			sin = -32'd982;
			cos = 32'd191;
			end
		else if (angle == 8'd170)
			begin
			sin = -32'd985;
			cos = 32'd174;
			end
		else if (angle == 8'd171)
			begin
			sin = -32'd988;
			cos = 32'd156;
			end
		else if (angle == 8'd172)
			begin
			sin = -32'd990;
			cos = 32'd139;
			end
		else if (angle == 8'd173)
			begin
			sin = -32'd993;
			cos = 32'd122;
			end
		else if (angle == 8'd174)
			begin
			sin = -32'd995;
			cos = 32'd105;
			end
		else if (angle == 8'd175)
			begin
			sin = -32'd996;
			cos = 32'd87;
			end
		else if (angle == 8'd176)
			begin
			sin = -32'd998;
			cos = 32'd70;
			end
		else if (angle == 8'd177)
			begin
			sin = -32'd999;
			cos = 32'd52;
			end
		else if (angle == 8'd178)
			begin
			sin = -32'd999;
			cos = 32'd35;
			end
		else if (angle == 8'd179)
			begin
			sin = -32'd1000;
			cos = 32'd17;
			end
		else
			begin
			sin = -32'd1000;
			cos = 32'd0;
			end
	end
endmodule