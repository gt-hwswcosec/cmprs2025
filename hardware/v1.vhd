library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


entity cmprcipher_trivium_v1 is
	port(clk, rst : in std_logic;
        key, IV : in std_logic_vector(127 downto 0);
		o_vld : out std_logic;
		keystream_bit_out : out std_logic);
end cmprcipher_trivium_v1;


architecture encrypt of cmprcipher_trivium_v1 is

type state_type is (setup, run);
signal keystream_bit : std_logic;
signal state : state_type;
signal s_reg : std_logic_vector(287 downto 0);
signal s: std_logic_vector(287 downto 0);
signal count : integer;

begin
	
    s(287) <= ((s_reg(286)));
    s(286) <= ((s_reg(285)));
    s(285) <= ((s_reg(284)));
    s(284) <= ((s_reg(283)));
    s(283) <= ((s_reg(282)));
    s(282) <= ((s_reg(281)));
    s(281) <= ((s_reg(280)));
    s(280) <= ((s_reg(279)));
    s(279) <= ((s_reg(278)));
    s(278) <= ((s_reg(277)));
    s(277) <= ((s_reg(276)));
    s(276) <= ((s_reg(275)));
    s(275) <= ((s_reg(274)));
    s(274) <= ((s_reg(273)));
    s(273) <= ((s_reg(272)));
    s(272) <= ((s_reg(271)));
    s(271) <= ((s_reg(270)));
    s(270) <= ((s_reg(287)) XOR (s_reg(269)));
    s(269) <= ((s_reg(268)));
    s(268) <= ((s_reg(267)));
    s(267) <= ((s_reg(266)));
    s(266) <= ((s_reg(265)));
    s(265) <= ((s_reg(287)) XOR (s_reg(264)));
    s(264) <= ((s_reg(263)));
    s(263) <= ((s_reg(262)));
    s(262) <= ((s_reg(261)));
    s(261) <= ((s_reg(260)));
    s(260) <= ((s_reg(259)));
    s(259) <= ((s_reg(258)));
    s(258) <= ((s_reg(257)));
    s(257) <= ((s_reg(256)));
    s(256) <= ((s_reg(255)));
    s(255) <= ((s_reg(254)));
    s(254) <= ((s_reg(253)));
    s(253) <= ((s_reg(252)));
    s(252) <= ((s_reg(251)));
    s(251) <= ((s_reg(250)));
    s(250) <= ((s_reg(249)));
    s(249) <= ((s_reg(248)));
    s(248) <= ((s_reg(247)));
    s(247) <= ((s_reg(246)));
    s(246) <= ((s_reg(245)));
    s(245) <= ((s_reg(244)));
    s(244) <= ((s_reg(243)));
    s(243) <= ((s_reg(242)));
    s(242) <= ((s_reg(241)));
    s(241) <= ((s_reg(240)));
    s(240) <= ((s_reg(239)));
    s(239) <= ((s_reg(238)));
    s(238) <= ((s_reg(237)));
    s(237) <= ((s_reg(236)));
    s(236) <= ((s_reg(235)));
    s(235) <= ((s_reg(234)));
    s(234) <= ((s_reg(233)));
    s(233) <= ((s_reg(232)));
    s(232) <= ((s_reg(231)));
    s(231) <= ((s_reg(230)));
    s(230) <= ((s_reg(229)));
    s(229) <= ((s_reg(228)));
    s(228) <= ((s_reg(227)));
    s(227) <= ((s_reg(226)));
    s(226) <= ((s_reg(225)));
    s(225) <= ((s_reg(224)));
    s(224) <= ((s_reg(223)));
    s(223) <= ((s_reg(222)));
    s(222) <= ((s_reg(221)));
    s(221) <= ((s_reg(287)) XOR (s_reg(220)));
    s(220) <= ((s_reg(219)));
    s(219) <= ((s_reg(218)));
    s(218) <= ((s_reg(217)));
    s(217) <= ((s_reg(216)));
    s(216) <= ((s_reg(215)));
    s(215) <= ((s_reg(214)));
    s(214) <= ((s_reg(213)));
    s(213) <= ((s_reg(212)));
    s(212) <= ((s_reg(211)));
    s(211) <= ((s_reg(210)));
    s(210) <= ((s_reg(287)) XOR (s_reg(209)));
    s(209) <= ((s_reg(208)));
    s(208) <= ((s_reg(207)));
    s(207) <= ((s_reg(206)));
    s(206) <= ((s_reg(205)));
    s(205) <= ((s_reg(204)));
    s(204) <= ((s_reg(287)) XOR (s_reg(203)));
    s(203) <= ((s_reg(202)));
    s(202) <= ((s_reg(201)));
    s(201) <= ((s_reg(200)));
    s(200) <= ((s_reg(199)));
    s(199) <= ((s_reg(198)));
    s(198) <= ((s_reg(197)));
    s(197) <= ((s_reg(196)));
    s(196) <= ((s_reg(195)));
    s(195) <= ((s_reg(194)));
    s(194) <= ((s_reg(193)));
    s(193) <= ((s_reg(192)));
    s(192) <= ((s_reg(191)));
    s(191) <= ((s_reg(190)));
    s(190) <= ((s_reg(189)));
    s(189) <= ((s_reg(188)));
    s(188) <= ((s_reg(187)));
    s(187) <= ((s_reg(186)));
    s(186) <= ((s_reg(185)));
    s(185) <= ((s_reg(184)));
    s(184) <= ((s_reg(183)));
    s(183) <= ((s_reg(182)));
    s(182) <= ((s_reg(181)));
    s(181) <= ((s_reg(287)));
    s(180) <= ((s_reg(179))) XOR 
        ((s_reg(238) AND s_reg(195) AND s_reg(194)) XOR (s_reg(266)) XOR (s_reg(272) AND s_reg(214) AND s_reg(241) AND s_reg(231)));
    s(179) <= ((s_reg(178))) XOR 
        ((s_reg(285)) XOR (s_reg(181) AND s_reg(287) AND s_reg(251)) XOR (s_reg(217) AND s_reg(286) AND s_reg(224) AND s_reg(215)) XOR (s_reg(287) AND s_reg(274)));
    s(178) <= ((s_reg(177))) XOR 
        ((s_reg(194) AND s_reg(212) AND s_reg(192) AND s_reg(250)));
    s(177) <= ((s_reg(176))) XOR 
        ((s_reg(214) AND s_reg(263)) XOR (s_reg(190)) XOR (s_reg(251) AND s_reg(248) AND s_reg(205) AND s_reg(188)));
    s(176) <= ((s_reg(175))) XOR 
        ((s_reg(214)) XOR (s_reg(256) AND s_reg(261)) XOR (s_reg(225) AND s_reg(261)) XOR (s_reg(208) AND s_reg(203) AND s_reg(260) AND s_reg(240)));
    s(175) <= ((s_reg(174))) XOR 
        ((s_reg(200) AND s_reg(196) AND s_reg(275) AND s_reg(279)) XOR (s_reg(203) AND s_reg(196) AND s_reg(235)) XOR (s_reg(228) AND s_reg(244)));
    s(174) <= ((s_reg(173))) XOR 
        ((s_reg(231) AND s_reg(218) AND s_reg(273)) XOR (s_reg(212)) XOR (s_reg(184)) XOR (s_reg(267)));
    s(173) <= ((s_reg(172)) XOR (s_reg(180))) XOR 
        ((s_reg(240)));
    s(172) <= ((s_reg(171))) XOR 
        ((s_reg(287) AND s_reg(210) AND s_reg(222) AND s_reg(209)));
    s(171) <= ((s_reg(170))) XOR 
        ((s_reg(252)) XOR (s_reg(255) AND s_reg(259)) XOR (s_reg(282)) XOR (s_reg(182)));
    s(170) <= ((s_reg(169))) XOR 
        ((s_reg(263) AND s_reg(269) AND s_reg(285)) XOR (s_reg(285) AND s_reg(252) AND s_reg(207)) XOR (s_reg(190) AND s_reg(252)));
    s(169) <= ((s_reg(168))) XOR 
        ((s_reg(206) AND s_reg(273) AND s_reg(207)) XOR (s_reg(236) AND s_reg(282) AND s_reg(265)) XOR (s_reg(246) AND s_reg(231)) XOR (s_reg(279) AND s_reg(183) AND s_reg(260) AND s_reg(192)));
    s(168) <= ((s_reg(167))) XOR 
        ((s_reg(202) AND s_reg(219) AND s_reg(280) AND s_reg(188)) XOR (s_reg(224) AND s_reg(249) AND s_reg(274) AND s_reg(197)));
    s(167) <= ((s_reg(166))) XOR 
        ((s_reg(228)));
    s(166) <= ((s_reg(165))) XOR 
        ((s_reg(210) AND s_reg(267)) XOR (s_reg(181)) XOR (s_reg(190) AND s_reg(248)) XOR (s_reg(249) AND s_reg(259) AND s_reg(271) AND s_reg(211)));
    s(165) <= ((s_reg(164))) XOR 
        ((s_reg(227) AND s_reg(226) AND s_reg(201)) XOR (s_reg(276) AND s_reg(190) AND s_reg(194)) XOR (s_reg(260)));
    s(164) <= ((s_reg(163))) XOR 
        ((s_reg(194)));
    s(163) <= ((s_reg(162))) XOR 
        ((s_reg(229) AND s_reg(222) AND s_reg(262) AND s_reg(212)) XOR (s_reg(222) AND s_reg(254) AND s_reg(280)));
    s(162) <= ((s_reg(161))) XOR 
        ((s_reg(201)) XOR (s_reg(211)) XOR (s_reg(225) AND s_reg(236)));
    s(161) <= ((s_reg(160))) XOR 
        ((s_reg(218) AND s_reg(232) AND s_reg(275)) XOR (s_reg(286)) XOR (s_reg(245)));
    s(160) <= ((s_reg(180)) XOR (s_reg(159))) XOR 
        ((s_reg(239) AND s_reg(226)) XOR (s_reg(184) AND s_reg(255) AND s_reg(197)) XOR (s_reg(269) AND s_reg(215) AND s_reg(255)));
    s(159) <= ((s_reg(158))) XOR 
        ((s_reg(264) AND s_reg(262) AND s_reg(279)) XOR (s_reg(242) AND s_reg(238)) XOR (s_reg(250) AND s_reg(193)) XOR (s_reg(213) AND s_reg(199)));
    s(158) <= ((s_reg(157))) XOR 
        ((s_reg(261) AND s_reg(200) AND s_reg(230)) XOR (s_reg(240) AND s_reg(283)) XOR (s_reg(240) AND s_reg(223)));
    s(157) <= ((s_reg(156))) XOR 
        ((s_reg(270) AND s_reg(184) AND s_reg(237) AND s_reg(240)) XOR (s_reg(228) AND s_reg(200) AND s_reg(242) AND s_reg(223)) XOR (s_reg(181) AND s_reg(255) AND s_reg(232)));
    s(156) <= ((s_reg(155))) XOR 
        ((s_reg(203)) XOR (s_reg(231) AND s_reg(220) AND s_reg(246) AND s_reg(283)) XOR (s_reg(198)) XOR (s_reg(199) AND s_reg(249)));
    s(155) <= ((s_reg(154))) XOR 
        ((s_reg(198) AND s_reg(230) AND s_reg(211)));
    s(154) <= ((s_reg(153))) XOR 
        ((s_reg(257)) XOR (s_reg(285) AND s_reg(272)) XOR (s_reg(210) AND s_reg(242)) XOR (s_reg(285)));
    s(153) <= ((s_reg(152))) XOR 
        ((s_reg(273) AND s_reg(243)) XOR (s_reg(259)) XOR (s_reg(230) AND s_reg(186)));
    s(152) <= ((s_reg(151))) XOR 
        ((s_reg(274) AND s_reg(264)) XOR (s_reg(244) AND s_reg(279) AND s_reg(224) AND s_reg(219)) XOR (s_reg(199) AND s_reg(230) AND s_reg(203)));
    s(151) <= ((s_reg(150))) XOR 
        ((s_reg(240) AND s_reg(236) AND s_reg(246)) XOR (s_reg(280) AND s_reg(234)) XOR (s_reg(211) AND s_reg(269)) XOR (s_reg(268) AND s_reg(199)));
    s(150) <= ((s_reg(149))) XOR 
        ((s_reg(276) AND s_reg(190)));
    s(149) <= ((s_reg(148))) XOR 
        ((s_reg(252) AND s_reg(189) AND s_reg(258)) XOR (s_reg(228) AND s_reg(274)) XOR (s_reg(216) AND s_reg(281) AND s_reg(244)) XOR (s_reg(274) AND s_reg(266)));
    s(148) <= ((s_reg(147))) XOR 
        ((s_reg(241) AND s_reg(258) AND s_reg(227) AND s_reg(211)));
    s(147) <= ((s_reg(146))) XOR 
        ((s_reg(214) AND s_reg(200) AND s_reg(213)) XOR (s_reg(229)) XOR (s_reg(280) AND s_reg(183) AND s_reg(216) AND s_reg(252)));
    s(146) <= ((s_reg(145))) XOR 
        ((s_reg(215) AND s_reg(216) AND s_reg(276) AND s_reg(236)) XOR (s_reg(216) AND s_reg(210)) XOR (s_reg(210)));
    s(145) <= ((s_reg(144))) XOR 
        ((s_reg(278) AND s_reg(238) AND s_reg(268) AND s_reg(225)) XOR (s_reg(241) AND s_reg(192)) XOR (s_reg(185)) XOR (s_reg(275) AND s_reg(284)));
    s(144) <= ((s_reg(143))) XOR 
        ((s_reg(263) AND s_reg(245) AND s_reg(210)) XOR (s_reg(226) AND s_reg(285) AND s_reg(203)) XOR (s_reg(258) AND s_reg(217)));
    s(143) <= ((s_reg(142))) XOR 
        ((s_reg(214) AND s_reg(224) AND s_reg(184)) XOR (s_reg(279) AND s_reg(210) AND s_reg(225) AND s_reg(266)));
    s(142) <= ((s_reg(141))) XOR 
        ((s_reg(181) AND s_reg(182) AND s_reg(206)));
    s(141) <= ((s_reg(140))) XOR 
        ((s_reg(279) AND s_reg(284) AND s_reg(258)) XOR (s_reg(271) AND s_reg(226) AND s_reg(227) AND s_reg(282)) XOR (s_reg(263) AND s_reg(246) AND s_reg(228) AND s_reg(200)) XOR (s_reg(238) AND s_reg(210)));
    s(140) <= ((s_reg(139))) XOR 
        ((s_reg(228) AND s_reg(216)));
    s(139) <= ((s_reg(138))) XOR 
        ((s_reg(286) AND s_reg(231) AND s_reg(216) AND s_reg(271)) XOR (s_reg(185) AND s_reg(203) AND s_reg(187)) XOR (s_reg(247) AND s_reg(244) AND s_reg(239) AND s_reg(196)) XOR (s_reg(240)));
    s(138) <= ((s_reg(137))) XOR 
        ((s_reg(225) AND s_reg(275) AND s_reg(223) AND s_reg(242)) XOR (s_reg(261) AND s_reg(183) AND s_reg(270)) XOR (s_reg(219)) XOR (s_reg(274) AND s_reg(273) AND s_reg(225)));
    s(137) <= ((s_reg(136))) XOR 
        ((s_reg(236)) XOR (s_reg(214) AND s_reg(285) AND s_reg(254)) XOR (s_reg(220)));
    s(136) <= ((s_reg(135))) XOR 
        ((s_reg(268) AND s_reg(185)));
    s(135) <= ((s_reg(134))) XOR 
        ((s_reg(226) AND s_reg(186) AND s_reg(273) AND s_reg(279)) XOR (s_reg(239) AND s_reg(208) AND s_reg(236)) XOR (s_reg(192)));
    s(134) <= ((s_reg(133))) XOR 
        ((s_reg(181) AND s_reg(251) AND s_reg(243)) XOR (s_reg(236) AND s_reg(235) AND s_reg(269)) XOR (s_reg(264) AND s_reg(268)));
    s(133) <= ((s_reg(132))) XOR 
        ((s_reg(212) AND s_reg(196) AND s_reg(281)) XOR (s_reg(215) AND s_reg(198) AND s_reg(245) AND s_reg(211)) XOR (s_reg(211) AND s_reg(275) AND s_reg(276)));
    s(132) <= ((s_reg(131))) XOR 
        ((s_reg(278) AND s_reg(269) AND s_reg(284) AND s_reg(276)) XOR (s_reg(186) AND s_reg(183) AND s_reg(273) AND s_reg(201)) XOR (s_reg(281) AND s_reg(217) AND s_reg(243)) XOR (s_reg(183) AND s_reg(283) AND s_reg(265) AND s_reg(250)));
    s(131) <= ((s_reg(130))) XOR 
        ((s_reg(218)) XOR (s_reg(188) AND s_reg(221) AND s_reg(282) AND s_reg(204)) XOR (s_reg(207) AND s_reg(187)));
    s(130) <= ((s_reg(129))) XOR 
        ((s_reg(256) AND s_reg(280)));
    s(129) <= ((s_reg(128))) XOR 
        ((s_reg(267)));
    s(128) <= ((s_reg(127))) XOR 
        ((s_reg(282) AND s_reg(185) AND s_reg(274)) XOR (s_reg(206)));
    s(127) <= ((s_reg(126))) XOR 
        ((s_reg(204) AND s_reg(220) AND s_reg(194) AND s_reg(275)) XOR (s_reg(209)) XOR (s_reg(252) AND s_reg(280) AND s_reg(212)) XOR (s_reg(205) AND s_reg(278) AND s_reg(233)));
    s(126) <= ((s_reg(125))) XOR 
        ((s_reg(265) AND s_reg(198)) XOR (s_reg(263) AND s_reg(194) AND s_reg(224)));
    s(125) <= ((s_reg(124))) XOR 
        ((s_reg(279) AND s_reg(211) AND s_reg(186)) XOR (s_reg(236)) XOR (s_reg(247) AND s_reg(220) AND s_reg(237)) XOR (s_reg(210) AND s_reg(194) AND s_reg(238)));
    s(124) <= ((s_reg(123))) XOR 
        ((s_reg(231) AND s_reg(185) AND s_reg(264)));
    s(123) <= ((s_reg(180)) XOR (s_reg(122))) XOR 
        ((s_reg(239) AND s_reg(245) AND s_reg(247)) XOR (s_reg(195) AND s_reg(232) AND s_reg(280) AND s_reg(215)));
    s(122) <= ((s_reg(121))) XOR 
        ((s_reg(284) AND s_reg(204) AND s_reg(235)) XOR (s_reg(186) AND s_reg(272) AND s_reg(216)) XOR (s_reg(280) AND s_reg(197) AND s_reg(238) AND s_reg(235)) XOR (s_reg(220) AND s_reg(253) AND s_reg(232)));
    s(121) <= ((s_reg(120))) XOR 
        ((s_reg(278) AND s_reg(207) AND s_reg(286)));
    s(120) <= ((s_reg(119))) XOR 
        ((s_reg(224) AND s_reg(192) AND s_reg(258)) XOR (s_reg(204)));
    s(119) <= ((s_reg(118))) XOR 
        ((s_reg(271) AND s_reg(272)) XOR (s_reg(232)) XOR (s_reg(267) AND s_reg(227) AND s_reg(223)));
    s(118) <= ((s_reg(117))) XOR 
        ((s_reg(284) AND s_reg(267)));
    s(117) <= ((s_reg(116))) XOR 
        ((s_reg(202) AND s_reg(259) AND s_reg(242) AND s_reg(249)) XOR (s_reg(269) AND s_reg(196) AND s_reg(245) AND s_reg(260)) XOR (s_reg(249) AND s_reg(187) AND s_reg(226)) XOR (s_reg(200)));
    s(116) <= ((s_reg(115))) XOR 
        ((s_reg(206) AND s_reg(197) AND s_reg(273)) XOR (s_reg(244)) XOR (s_reg(186) AND s_reg(259) AND s_reg(230) AND s_reg(195)) XOR (s_reg(185) AND s_reg(263) AND s_reg(267)));
    s(115) <= ((s_reg(114))) XOR 
        ((s_reg(230)) XOR (s_reg(247)));
    s(114) <= ((s_reg(113))) XOR 
        ((s_reg(287) AND s_reg(192) AND s_reg(249) AND s_reg(183)));
    s(113) <= ((s_reg(180)) XOR (s_reg(112))) XOR 
        ((s_reg(251)));
    s(112) <= ((s_reg(111))) XOR 
        ((s_reg(181) AND s_reg(192)) XOR (s_reg(240) AND s_reg(204)));
    s(111) <= ((s_reg(110))) XOR 
        ((s_reg(260) AND s_reg(281) AND s_reg(213)) XOR (s_reg(223) AND s_reg(271) AND s_reg(189) AND s_reg(258)) XOR (s_reg(218) AND s_reg(248) AND s_reg(242) AND s_reg(271)) XOR (s_reg(277) AND s_reg(243) AND s_reg(276) AND s_reg(239)));
    s(110) <= ((s_reg(180)) XOR (s_reg(109))) XOR 
        ((s_reg(244)) XOR (s_reg(268) AND s_reg(257) AND s_reg(228) AND s_reg(275)) XOR (s_reg(257) AND s_reg(231)) XOR (s_reg(225) AND s_reg(254) AND s_reg(221) AND s_reg(203)));
    s(109) <= ((s_reg(108))) XOR 
        ((s_reg(276) AND s_reg(186) AND s_reg(232) AND s_reg(233)));
    s(108) <= ((s_reg(107))) XOR 
        ((s_reg(263) AND s_reg(258) AND s_reg(193)) XOR (s_reg(275) AND s_reg(267) AND s_reg(279) AND s_reg(200)));
    s(107) <= ((s_reg(106))) XOR 
        ((s_reg(273) AND s_reg(196)));
    s(106) <= ((s_reg(105))) XOR 
        ((s_reg(202) AND s_reg(286) AND s_reg(201) AND s_reg(220)));
    s(105) <= ((s_reg(104))) XOR 
        ((s_reg(197) AND s_reg(211) AND s_reg(243) AND s_reg(276)) XOR (s_reg(182) AND s_reg(281)) XOR (s_reg(240)));
    s(104) <= ((s_reg(103))) XOR 
        ((s_reg(258) AND s_reg(233) AND s_reg(190) AND s_reg(247)) XOR (s_reg(207)) XOR (s_reg(198) AND s_reg(266)) XOR (s_reg(200) AND s_reg(255) AND s_reg(242)));
    s(103) <= ((s_reg(102))) XOR 
        ((s_reg(187) AND s_reg(238)) XOR (s_reg(204)));
    s(102) <= ((s_reg(101))) XOR 
        ((s_reg(204)) XOR (s_reg(224)) XOR (s_reg(225) AND s_reg(284)));
    s(101) <= ((s_reg(100))) XOR 
        ((s_reg(223) AND s_reg(284)));
    s(100) <= ((s_reg(99))) XOR 
        ((s_reg(269) AND s_reg(186) AND s_reg(206)));
    s(99) <= ((s_reg(98))) XOR 
        ((s_reg(272) AND s_reg(224) AND s_reg(265) AND s_reg(227)) XOR (s_reg(182) AND s_reg(209)) XOR (s_reg(285) AND s_reg(204) AND s_reg(198) AND s_reg(199)));
    s(98) <= ((s_reg(97))) XOR 
        ((s_reg(193) AND s_reg(211) AND s_reg(215) AND s_reg(222)) XOR (s_reg(249)) XOR (s_reg(261) AND s_reg(231)) XOR (s_reg(238)));
    s(97) <= ((s_reg(96))) XOR 
        ((s_reg(280) AND s_reg(187) AND s_reg(222)));
    s(96) <= ((s_reg(95))) XOR 
        ((s_reg(197) AND s_reg(186)));
    s(95) <= ((s_reg(94))) XOR 
        ((s_reg(195)));
    s(94) <= ((s_reg(93))) XOR 
        ((s_reg(267) AND s_reg(231) AND s_reg(258) AND s_reg(272)));
    s(93) <= ((s_reg(92))) XOR 
        ((s_reg(188) AND s_reg(223)) XOR (s_reg(275) AND s_reg(270)));
    s(92) <= ((s_reg(180))) XOR 
        ((s_reg(259) AND s_reg(250) AND s_reg(205)) XOR (s_reg(212) AND s_reg(185)));
    s(91) <= ((s_reg(90))) XOR 
        ((s_reg(160) AND s_reg(260) AND s_reg(138) AND s_reg(166)));
    s(90) <= ((s_reg(89))) XOR 
        ((s_reg(102)) XOR (s_reg(199)) XOR (s_reg(224) AND s_reg(252)) XOR (s_reg(97)));
    s(89) <= ((s_reg(88))) XOR 
        ((s_reg(181) AND s_reg(96)) XOR (s_reg(190) AND s_reg(218) AND s_reg(129)) XOR (s_reg(119)));
    s(88) <= ((s_reg(87))) XOR 
        ((s_reg(141) AND s_reg(98) AND s_reg(147)) XOR (s_reg(152)) XOR (s_reg(95) AND s_reg(286) AND s_reg(110)) XOR (s_reg(237) AND s_reg(139) AND s_reg(193) AND s_reg(151)));
    s(87) <= ((s_reg(86))) XOR 
        ((s_reg(149)));
    s(86) <= ((s_reg(85))) XOR 
        ((s_reg(151)) XOR (s_reg(129) AND s_reg(186)));
    s(85) <= ((s_reg(84))) XOR 
        ((s_reg(146) AND s_reg(242)));
    s(84) <= ((s_reg(83))) XOR 
        ((s_reg(268) AND s_reg(200) AND s_reg(286)) XOR (s_reg(158)) XOR (s_reg(112) AND s_reg(115) AND s_reg(199) AND s_reg(194)) XOR (s_reg(99) AND s_reg(191) AND s_reg(266) AND s_reg(220)));
    s(83) <= ((s_reg(82))) XOR 
        ((s_reg(141)) XOR (s_reg(181) AND s_reg(173)));
    s(82) <= ((s_reg(81))) XOR 
        ((s_reg(241)) XOR (s_reg(126) AND s_reg(257)));
    s(81) <= ((s_reg(80))) XOR 
        ((s_reg(123)) XOR (s_reg(287) AND s_reg(270) AND s_reg(93)));
    s(80) <= ((s_reg(79))) XOR 
        ((s_reg(110) AND s_reg(146) AND s_reg(194)) XOR (s_reg(250) AND s_reg(118) AND s_reg(255)) XOR (s_reg(172) AND s_reg(186) AND s_reg(202) AND s_reg(156)) XOR (s_reg(94)));
    s(79) <= ((s_reg(78))) XOR 
        ((s_reg(205) AND s_reg(114)));
    s(78) <= ((s_reg(77))) XOR 
        ((s_reg(228)) XOR (s_reg(168)) XOR (s_reg(233) AND s_reg(138) AND s_reg(133) AND s_reg(260)));
    s(77) <= ((s_reg(76))) XOR 
        ((s_reg(120) AND s_reg(250) AND s_reg(212)));
    s(76) <= ((s_reg(75))) XOR 
        ((s_reg(285) AND s_reg(215) AND s_reg(144) AND s_reg(236)) XOR (s_reg(215) AND s_reg(133) AND s_reg(279)));
    s(75) <= ((s_reg(91)) XOR (s_reg(74))) XOR 
        ((s_reg(212) AND s_reg(216)) XOR (s_reg(286) AND s_reg(109) AND s_reg(171) AND s_reg(248)) XOR (s_reg(262) AND s_reg(266) AND s_reg(103) AND s_reg(284)) XOR (s_reg(182) AND s_reg(248) AND s_reg(221)));
    s(74) <= ((s_reg(73))) XOR 
        ((s_reg(146) AND s_reg(282) AND s_reg(264)) XOR (s_reg(162) AND s_reg(282) AND s_reg(209) AND s_reg(143)) XOR (s_reg(193) AND s_reg(93)) XOR (s_reg(210)));
    s(73) <= ((s_reg(72))) XOR 
        ((s_reg(116)) XOR (s_reg(209) AND s_reg(185) AND s_reg(219)) XOR (s_reg(105) AND s_reg(223) AND s_reg(238)));
    s(72) <= ((s_reg(71))) XOR 
        ((s_reg(196) AND s_reg(110) AND s_reg(223) AND s_reg(199)) XOR (s_reg(101) AND s_reg(110) AND s_reg(245)) XOR (s_reg(227)) XOR (s_reg(122)));
    s(71) <= ((s_reg(70))) XOR 
        ((s_reg(287) AND s_reg(155)) XOR (s_reg(104) AND s_reg(242) AND s_reg(140) AND s_reg(178)));
    s(70) <= ((s_reg(69))) XOR 
        ((s_reg(147) AND s_reg(236) AND s_reg(193) AND s_reg(149)) XOR (s_reg(218) AND s_reg(195)) XOR (s_reg(196) AND s_reg(111) AND s_reg(140)));
    s(69) <= ((s_reg(68))) XOR 
        ((s_reg(277) AND s_reg(153)));
    s(68) <= ((s_reg(67))) XOR 
        ((s_reg(116) AND s_reg(144)) XOR (s_reg(244) AND s_reg(163)) XOR (s_reg(200)));
    s(67) <= ((s_reg(66))) XOR 
        ((s_reg(180) AND s_reg(132)) XOR (s_reg(209) AND s_reg(274) AND s_reg(203) AND s_reg(144)));
    s(66) <= ((s_reg(65))) XOR 
        ((s_reg(131) AND s_reg(132)) XOR (s_reg(105) AND s_reg(167)) XOR (s_reg(133) AND s_reg(130) AND s_reg(93)) XOR (s_reg(235)));
    s(65) <= ((s_reg(64))) XOR 
        ((s_reg(264) AND s_reg(278) AND s_reg(153) AND s_reg(205)) XOR (s_reg(245)) XOR (s_reg(220) AND s_reg(191) AND s_reg(275)));
    s(64) <= ((s_reg(63))) XOR 
        ((s_reg(97) AND s_reg(137) AND s_reg(171)));
    s(63) <= ((s_reg(62))) XOR 
        ((s_reg(124)) XOR (s_reg(120)) XOR (s_reg(181) AND s_reg(166) AND s_reg(136) AND s_reg(252)));
    s(62) <= ((s_reg(61))) XOR 
        ((s_reg(213) AND s_reg(145)));
    s(61) <= ((s_reg(60))) XOR 
        ((s_reg(110) AND s_reg(258) AND s_reg(197) AND s_reg(163)) XOR (s_reg(228) AND s_reg(226) AND s_reg(93) AND s_reg(149)));
    s(60) <= ((s_reg(59))) XOR 
        ((s_reg(271) AND s_reg(116) AND s_reg(248) AND s_reg(92)) XOR (s_reg(176)) XOR (s_reg(275) AND s_reg(173)));
    s(59) <= ((s_reg(58))) XOR 
        ((s_reg(247)) XOR (s_reg(101)) XOR (s_reg(212) AND s_reg(159)));
    s(58) <= ((s_reg(57))) XOR 
        ((s_reg(174) AND s_reg(249) AND s_reg(92)) XOR (s_reg(168) AND s_reg(178) AND s_reg(251) AND s_reg(146)) XOR (s_reg(260) AND s_reg(149)) XOR (s_reg(223) AND s_reg(259)));
    s(57) <= ((s_reg(56))) XOR 
        ((s_reg(249) AND s_reg(177) AND s_reg(256)));
    s(56) <= ((s_reg(55))) XOR 
        ((s_reg(285)) XOR (s_reg(287) AND s_reg(161) AND s_reg(111)));
    s(55) <= ((s_reg(54))) XOR 
        ((s_reg(100) AND s_reg(181) AND s_reg(214)) XOR (s_reg(159)));
    s(54) <= ((s_reg(53))) XOR 
        ((s_reg(151) AND s_reg(255) AND s_reg(185) AND s_reg(156)));
    s(53) <= ((s_reg(52))) XOR 
        ((s_reg(209)) XOR (s_reg(219) AND s_reg(275) AND s_reg(265)));
    s(52) <= ((s_reg(51))) XOR 
        ((s_reg(111) AND s_reg(142) AND s_reg(106)));
    s(51) <= ((s_reg(50))) XOR 
        ((s_reg(102) AND s_reg(185) AND s_reg(175)) XOR (s_reg(216)));
    s(50) <= ((s_reg(91)) XOR (s_reg(49))) XOR 
        ((s_reg(203) AND s_reg(169) AND s_reg(94) AND s_reg(108)));
    s(49) <= ((s_reg(48))) XOR 
        ((s_reg(212) AND s_reg(183)) XOR (s_reg(197) AND s_reg(273) AND s_reg(112) AND s_reg(223)));
    s(48) <= ((s_reg(47))) XOR 
        ((s_reg(153) AND s_reg(215)) XOR (s_reg(263) AND s_reg(164)));
    s(47) <= ((s_reg(46))) XOR 
        ((s_reg(281) AND s_reg(145)) XOR (s_reg(104) AND s_reg(212) AND s_reg(176) AND s_reg(278)) XOR (s_reg(232) AND s_reg(176) AND s_reg(132)) XOR (s_reg(181)));
    s(46) <= ((s_reg(91)) XOR (s_reg(45))) XOR 
        ((s_reg(249) AND s_reg(130)) XOR (s_reg(228)));
    s(45) <= ((s_reg(44))) XOR 
        ((s_reg(181) AND s_reg(203)) XOR (s_reg(106)) XOR (s_reg(277) AND s_reg(251) AND s_reg(124)) XOR (s_reg(157)));
    s(44) <= ((s_reg(43))) XOR 
        ((s_reg(234)) XOR (s_reg(202) AND s_reg(213) AND s_reg(143) AND s_reg(229)) XOR (s_reg(220) AND s_reg(180) AND s_reg(140) AND s_reg(259)) XOR (s_reg(196) AND s_reg(110) AND s_reg(150) AND s_reg(242)));
    s(43) <= ((s_reg(42))) XOR 
        ((s_reg(270) AND s_reg(164) AND s_reg(202) AND s_reg(126)) XOR (s_reg(184) AND s_reg(237) AND s_reg(105)));
    s(42) <= ((s_reg(41))) XOR 
        ((s_reg(183)));
    s(41) <= ((s_reg(40))) XOR 
        ((s_reg(214) AND s_reg(224) AND s_reg(157)) XOR (s_reg(272) AND s_reg(212)));
    s(40) <= ((s_reg(39))) XOR 
        ((s_reg(194) AND s_reg(150) AND s_reg(227)) XOR (s_reg(215)));
    s(39) <= ((s_reg(38))) XOR 
        ((s_reg(268) AND s_reg(130) AND s_reg(121) AND s_reg(205)) XOR (s_reg(140) AND s_reg(202) AND s_reg(277) AND s_reg(278)) XOR (s_reg(242)) XOR (s_reg(270) AND s_reg(204)));
    s(38) <= ((s_reg(37))) XOR 
        ((s_reg(133) AND s_reg(243) AND s_reg(132) AND s_reg(272)) XOR (s_reg(119)) XOR (s_reg(112) AND s_reg(228) AND s_reg(276) AND s_reg(222)) XOR (s_reg(259) AND s_reg(94) AND s_reg(128) AND s_reg(274)));
    s(37) <= ((s_reg(36))) XOR 
        ((s_reg(201)) XOR (s_reg(260) AND s_reg(213) AND s_reg(154)) XOR (s_reg(94)) XOR (s_reg(277)));
    s(36) <= ((s_reg(35))) XOR 
        ((s_reg(248) AND s_reg(146) AND s_reg(179)) XOR (s_reg(142) AND s_reg(203) AND s_reg(200)) XOR (s_reg(166) AND s_reg(285) AND s_reg(202) AND s_reg(261)) XOR (s_reg(254) AND s_reg(239) AND s_reg(168)));
    s(35) <= ((s_reg(34))) XOR 
        ((s_reg(254)) XOR (s_reg(174) AND s_reg(228)) XOR (s_reg(244) AND s_reg(284) AND s_reg(115)));
    s(34) <= ((s_reg(33))) XOR 
        ((s_reg(285) AND s_reg(107) AND s_reg(252) AND s_reg(138)) XOR (s_reg(216) AND s_reg(150) AND s_reg(236)) XOR (s_reg(160) AND s_reg(278) AND s_reg(149)));
    s(33) <= ((s_reg(32))) XOR 
        ((s_reg(278)));
    s(32) <= ((s_reg(31))) XOR 
        ((s_reg(230) AND s_reg(118)) XOR (s_reg(212) AND s_reg(108)) XOR (s_reg(241) AND s_reg(144) AND s_reg(188)) XOR (s_reg(104) AND s_reg(177)));
    s(31) <= ((s_reg(91))) XOR 
        ((s_reg(162) AND s_reg(148) AND s_reg(138) AND s_reg(92)) XOR (s_reg(220) AND s_reg(276) AND s_reg(216) AND s_reg(190)) XOR (s_reg(173)));
    s(30) <= ((s_reg(29))) XOR 
        ((s_reg(70) AND s_reg(79) AND s_reg(57) AND s_reg(232)) XOR (s_reg(261)) XOR (s_reg(217) AND s_reg(87) AND s_reg(228)) XOR (s_reg(144) AND s_reg(207) AND s_reg(53)));
    s(29) <= ((s_reg(28))) XOR 
        ((s_reg(260) AND s_reg(275)) XOR (s_reg(62)) XOR (s_reg(118) AND s_reg(176)) XOR (s_reg(243) AND s_reg(86) AND s_reg(85)));
    s(28) <= ((s_reg(27))) XOR 
        ((s_reg(163) AND s_reg(93)) XOR (s_reg(169) AND s_reg(167)) XOR (s_reg(128) AND s_reg(145) AND s_reg(194)));
    s(27) <= ((s_reg(26))) XOR 
        ((s_reg(49) AND s_reg(44) AND s_reg(191) AND s_reg(251)));
    s(26) <= ((s_reg(25))) XOR 
        ((s_reg(256) AND s_reg(84) AND s_reg(186)) XOR (s_reg(126)) XOR (s_reg(271)));
    s(25) <= ((s_reg(24))) XOR 
        ((s_reg(87) AND s_reg(68) AND s_reg(259) AND s_reg(86)));
    s(24) <= ((s_reg(23))) XOR 
        ((s_reg(76)) XOR (s_reg(193) AND s_reg(195)));
    s(23) <= ((s_reg(22))) XOR 
        ((s_reg(40)));
    s(22) <= ((s_reg(21))) XOR 
        ((s_reg(157) AND s_reg(80)) XOR (s_reg(124) AND s_reg(216)) XOR (s_reg(125) AND s_reg(270) AND s_reg(77)));
    s(21) <= ((s_reg(20))) XOR 
        ((s_reg(283) AND s_reg(190) AND s_reg(70)) XOR (s_reg(101)) XOR (s_reg(263)) XOR (s_reg(39)));
    s(20) <= ((s_reg(19))) XOR 
        ((s_reg(132) AND s_reg(194)) XOR (s_reg(110) AND s_reg(242) AND s_reg(153)) XOR (s_reg(122)) XOR (s_reg(84) AND s_reg(162) AND s_reg(199) AND s_reg(271)));
    s(19) <= ((s_reg(18))) XOR 
        ((s_reg(264) AND s_reg(172) AND s_reg(69)) XOR (s_reg(260)) XOR (s_reg(177) AND s_reg(156) AND s_reg(66) AND s_reg(36)));
    s(18) <= ((s_reg(17))) XOR 
        ((s_reg(224) AND s_reg(248) AND s_reg(249)) XOR (s_reg(102) AND s_reg(137) AND s_reg(82)) XOR (s_reg(182) AND s_reg(243) AND s_reg(206)));
    s(17) <= ((s_reg(16))) XOR 
        ((s_reg(100)) XOR (s_reg(262) AND s_reg(272) AND s_reg(252) AND s_reg(189)) XOR (s_reg(184) AND s_reg(202) AND s_reg(128)));
    s(16) <= ((s_reg(15))) XOR 
        ((s_reg(103) AND s_reg(243)));
    s(15) <= ((s_reg(14))) XOR 
        ((s_reg(179) AND s_reg(122)) XOR (s_reg(62) AND s_reg(242) AND s_reg(267)) XOR (s_reg(269) AND s_reg(33) AND s_reg(167) AND s_reg(47)) XOR (s_reg(108) AND s_reg(154)));
    s(14) <= ((s_reg(13))) XOR 
        ((s_reg(263) AND s_reg(41) AND s_reg(171)) XOR (s_reg(283) AND s_reg(270)) XOR (s_reg(171) AND s_reg(242) AND s_reg(57) AND s_reg(183)));
    s(13) <= ((s_reg(12))) XOR 
        ((s_reg(145) AND s_reg(233) AND s_reg(250) AND s_reg(270)) XOR (s_reg(171) AND s_reg(116) AND s_reg(154)) XOR (s_reg(133) AND s_reg(73) AND s_reg(173)) XOR (s_reg(192) AND s_reg(85) AND s_reg(64)));
    s(12) <= ((s_reg(11))) XOR 
        ((s_reg(186)));
    s(11) <= ((s_reg(10))) XOR 
        ((s_reg(143) AND s_reg(225)) XOR (s_reg(120)) XOR (s_reg(80) AND s_reg(287)));
    s(10) <= ((s_reg(9))) XOR 
        ((s_reg(139) AND s_reg(251)));
    s(9) <= ((s_reg(8))) XOR 
        ((s_reg(252) AND s_reg(85)));
    s(8) <= ((s_reg(7))) XOR 
        ((s_reg(260) AND s_reg(129) AND s_reg(138)) XOR (s_reg(152) AND s_reg(90)));
    s(7) <= ((s_reg(6))) XOR 
        ((s_reg(270)));
    s(6) <= ((s_reg(5))) XOR 
        ((s_reg(257) AND s_reg(202) AND s_reg(74)) XOR (s_reg(157) AND s_reg(90)) XOR (s_reg(166) AND s_reg(122)));
    s(5) <= ((s_reg(4))) XOR 
        ((s_reg(75)) XOR (s_reg(122) AND s_reg(103)));
    s(4) <= ((s_reg(3))) XOR 
        ((s_reg(222) AND s_reg(41)) XOR (s_reg(90) AND s_reg(221)) XOR (s_reg(203) AND s_reg(35) AND s_reg(287)));
    s(3) <= ((s_reg(2)) XOR (s_reg(30))) XOR 
        ((s_reg(179) AND s_reg(239)) XOR (s_reg(92)) XOR (s_reg(138) AND s_reg(238)));
    s(2) <= ((s_reg(1)) XOR (s_reg(30))) XOR 
        ((s_reg(194) AND s_reg(103)));
    s(1) <= ((s_reg(30)) XOR (s_reg(0))) XOR 
        ((s_reg(44)) XOR (s_reg(196) AND s_reg(185) AND s_reg(212)) XOR (s_reg(106) AND s_reg(50) AND s_reg(257)) XOR (s_reg(189) AND s_reg(269)));
    s(0) <= ((s_reg(30))) XOR 
        ((s_reg(131)) XOR (s_reg(127) AND s_reg(64) AND s_reg(192) AND s_reg(164)));

--state machine
process(rst, clk)
variable temp : std_logic_vector(143 downto 0);
begin
if (rst = '1') then
	state <= setup;
	count <= 0;
	o_vld <= '0';
	s_reg(287 downto 160) <= key(127 downto 0);
	s_reg(159 downto 32) <= IV(127 downto 0);
	s_reg(31 downto 0) <= "11111111111111111111111111111111";
elsif(clk'event and clk='1') then
	case state is
		when setup =>
			if (count = 101) then
				state <= run;
				o_vld <= '1';
			else
        if (count = 50) then -- state swapping
	  temp := s_reg(287 downto 144);
          s_reg(287 downto 144) <= s(143 downto 0);
          s_reg(143 downto 0) <= temp;
        else
          s_reg <= s;
        end if;
				count <= count + 1;
				state <= setup;
				o_vld <= '0';
			end if;
		when run =>
        s_reg <= s;
	end case;

end if;
end process;
process(rst, clk)
begin
if (rst ='1') then
keystream_bit <= '0';
elsif(clk'event and clk ='1') then
case state is
	when run =>
		keystream_bit <= s_reg(0) xor s_reg(3) xor s_reg(7);
	when setup =>
end case;
end if;
end process;
keystream_bit_out <= keystream_bit;
end encrypt;
