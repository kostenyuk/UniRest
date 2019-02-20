
Функция ПолучитьТаблицуСтиля(ПрименительноHTML = Ложь) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	СтилиСхемСтолов.Состояние КАК Состояние,
	|	СтилиСхемСтолов.Стиль,
	|	НЕОПРЕДЕЛЕНО КАК СхемаЦветТекста,
	|	НЕОПРЕДЕЛЕНО КАК СхемаЦветФона,
	|	НЕОПРЕДЕЛЕНО КАК СхемаЦветРамки,
	|	НЕОПРЕДЕЛЕНО КАК СписокЦветТекста,
	|	НЕОПРЕДЕЛЕНО КАК СписокЦветФона
	|ИЗ
	|	РегистрСведений.СтилиСхемСтолов КАК СтилиСхемСтолов
	|
	|УПОРЯДОЧИТЬ ПО
	|	СтилиСхемСтолов.Состояние.Порядок";
	ТаблицаСтиля = Запрос.Выполнить().Выгрузить();
	
	Если ПрименительноHTML Тогда
		ЦветСброса = "auto";	
	Иначе
		ЦветСброса = Неопределено;	
	КонецЕсли;
	
	Для Каждого СтрокаТаблицыСтиля Из ТаблицаСтиля Цикл
		Структура = СтрокаТаблицыСтиля.Стиль.Получить();
		
		Если (Структура = Неопределено) Тогда
			
			СтрокаТаблицыСтиля.СхемаЦветТекста = ЦветСброса;
			СтрокаТаблицыСтиля.СхемаЦветФона = ЦветСброса;
			СтрокаТаблицыСтиля.СхемаЦветРамки = ЦветСброса;
			
			СтрокаТаблицыСтиля.СписокЦветТекста = ЦветСброса;
			СтрокаТаблицыСтиля.СписокЦветФона = ЦветСброса;
			
		Иначе
			
			Структура.Свойство("СхемаЦветТекста", СтрокаТаблицыСтиля.СхемаЦветТекста);
			Структура.Свойство("СхемаЦветФона", СтрокаТаблицыСтиля.СхемаЦветФона);
			Структура.Свойство("СхемаЦветРамки", СтрокаТаблицыСтиля.СхемаЦветРамки);
			
			Структура.Свойство("СписокЦветТекста", СтрокаТаблицыСтиля.СписокЦветТекста);
			Структура.Свойство("СписокЦветФона", СтрокаТаблицыСтиля.СписокЦветФона);
			
			СтрокаТаблицыСтиля.СхемаЦветТекста = СброситьЦвет(СтрокаТаблицыСтиля.СхемаЦветТекста, ЦветаСтиля.ЦветТекстаПоля, ЦветСброса);
			СтрокаТаблицыСтиля.СхемаЦветФона = СброситьЦвет(СтрокаТаблицыСтиля.СхемаЦветФона, ЦветаСтиля.ЦветФонаПоля, ЦветСброса);
			СтрокаТаблицыСтиля.СхемаЦветРамки = СброситьЦвет(СтрокаТаблицыСтиля.СхемаЦветРамки, ЦветаСтиля.ЦветРамки, ЦветСброса);
			
			СтрокаТаблицыСтиля.СписокЦветТекста = СброситьЦвет(СтрокаТаблицыСтиля.СписокЦветТекста, ЦветаСтиля.ЦветТекстаПоля, ЦветСброса);
			СтрокаТаблицыСтиля.СписокЦветФона = СброситьЦвет(СтрокаТаблицыСтиля.СписокЦветФона, ЦветаСтиля.ЦветФонаПоля, ЦветСброса);
			
		КонецЕсли;
		
		Если ПрименительноHTML Тогда
			СтрокаТаблицыСтиля.СхемаЦветТекста = BringColor(СтрокаТаблицыСтиля.СхемаЦветТекста);
			СтрокаТаблицыСтиля.СхемаЦветФона = BringColor(СтрокаТаблицыСтиля.СхемаЦветФона);
			СтрокаТаблицыСтиля.СхемаЦветРамки = BringColor(СтрокаТаблицыСтиля.СхемаЦветРамки);
			
			СтрокаТаблицыСтиля.СписокЦветТекста = BringColor(СтрокаТаблицыСтиля.СписокЦветТекста);
			СтрокаТаблицыСтиля.СписокЦветФона = BringColor(СтрокаТаблицыСтиля.СписокЦветФона);
		КонецЕсли;

	КонецЦикла;
	
	ТаблицаСтиля.Колонки.Удалить("Стиль");
	
	Возврат ТаблицаСтиля;
	
КонецФункции // ПолучитьТаблицуСтиля()


Функция СброситьЦвет(Цвет, ЦветУсловия, ЦветСброса)
	
	Если (Цвет = ЦветУсловия) Тогда
		Возврат ЦветСброса;
	КонецЕсли;
	
	Возврат Цвет;
	
КонецФункции // СброситьЦвет()


Функция BringColor(value)
	
	result = value;
	if (not TypeOf(result) = Type("Color")) then
		return result;
	endif;	
	
	// Цвета стиля разработчика.
	if (value.type = ColorType.StyleItem) then
		for each element in Metadata.StyleItems do
			if (element.type = Metadata.ObjectProperties.StyleElementType.Color) and (result = StyleColors[element.name]) then
				result = element.value; break;
			endif;
		enddo;
	endif;
		
	// Цвета стиля платформы.
	if (result.type = ColorType.StyleItem) then
		if    (result = StyleColors.FieldAlternativeBackColor) then result = new Color(245, 251, 247);
		elsif (result = StyleColors.ReportLineColor) then result = new Color(204, 192, 133);
		elsif (result = StyleColors.SpecialTextColor) then result = new Color(255, 0, 0);
		elsif (result = StyleColors.NegativeTextColor) then result = new Color(255, 0, 0);
		elsif (result = StyleColors.BorderColor) then result = new Color(179, 172, 134);
		elsif (result = StyleColors.FieldSelectedTextColor) then result = new Color(255, 255, 255);
		elsif (result = StyleColors.ButtonTextColor) then result = new Color(89, 67, 4);
		elsif (result = StyleColors.ToolTipTextColor) then result = new Color(0, 0, 0);
		elsif (result = StyleColors.FieldTextColor) then result = new Color(0, 0, 0);
		elsif (result = StyleColors.FormTextColor) then result = new Color(65, 48, 3);
		elsif (result = StyleColors.FieldSelectionBackColor) then result = new Color(83, 106, 194);
		elsif (result = StyleColors.ReportGroup1BackColor) then result = new Color(248, 242, 216);
		elsif (result = StyleColors.ReportGroup2BackColor) then result = new Color(251, 249, 236);
		elsif (result = StyleColors.ButtonBackColor) then result = new Color(245, 242, 221);
		elsif (result = StyleColors.ToolTipBackColor) then result = new Color(255, 250, 217);
		elsif (result = StyleColors.FieldBackColor) then result = new Color(255, 255, 255);
		elsif (result = StyleColors.FormBackColor) then result = new Color(252, 250, 235);
		elsif (result = StyleColors.ReportHeaderBackColor) then result = Новый Color(244, 236, 197);
		endif;
	endif;
	
	// Цвета Windows (Windows 7 default color theme).
	if (result.type = ColorType.WindowsColor) then
		if    (result = WindowsColors.ActiveBorder) then result = new Color(180, 180, 180);
		elsif (result = WindowsColors.InactiveBorder) then result = new Color(244, 247, 252);
		elsif (result = WindowsColors.ActiveTitleBar) then result = new Color(153, 180, 209);
		elsif (result = WindowsColors.InactiveTitleBar) then result = new Color(191, 205, 219);
		elsif (result = WindowsColors.ButtonFace) then result = new Color(240, 240, 240);
		elsif (result = WindowsColors.ButtonHighlight) then result = new Color(255, 255, 255);
		elsif (result = WindowsColors.Highlight) then result = new Color(51, 153, 255);
		elsif (result = WindowsColors.ToolTip) then result = new Color(255, 255, 225);
		elsif (result = WindowsColors.ScrollBar) then result = new Color(200, 200, 200);
		elsif (result = WindowsColors.ApplicationWorkspace) then result = new Color(171, 171, 171);
		elsif (result = WindowsColors.Desktop) then result = new Color(0, 0, 0);
		elsif (result = WindowsColors.WindowFrame) then result = new Color(180, 180, 180);
		elsif (result = WindowsColors.MenuBar) then result = new Color(240, 240, 240);
		elsif (result = WindowsColors.ActiveTitleBarText) then result = new Color(0, 0, 0);
		elsif (result = WindowsColors.InactiveTitleBarText) then result = new Color(67, 78, 84);
		elsif (result = WindowsColors.ButtonText) then result = new Color(0, 0, 0);
		elsif (result = WindowsColors.DisabledText) then result = new Color(109, 109, 109);
		elsif (result = WindowsColors.WindowText) then result = new Color(0, 0, 0);
		elsif (result = WindowsColors.HighlightText) then result = new Color(255, 255, 255);
		elsif (result = WindowsColors.ToolTipText) then result = new Color(255, 255, 255);
		elsif (result = WindowsColors.MenuItemText) then result = new Color(0, 0, 0);
		elsif (result = WindowsColors.ButtonShadow) then result = new Color(160, 160, 160);
		elsif (result = WindowsColors.ButtonLightShadow) then result = new Color(227, 227, 227);
		elsif (result = WindowsColors.ButtonDarkShadow) then result = new Color(105, 105, 105);
		elsif (result = WindowsColors.WindowBackground) then result = new Color(255, 255, 255);
		endif;
	endif;
			
	// Цвета WEB.
	if (result.type = ColorType.WebColor) then
		if    (result = WebColors.White) then result = new Color(255, 255, 255);
		elsif (result = WebColors.Snow) then result = new Color(255, 250, 250);
		elsif (result = WebColors.HoneyDew) then result = new Color(240, 255, 240);
		elsif (result = WebColors.MintCream) then result = new Color(245, 255, 250);
		elsif (result = WebColors.Azure) then result = new Color(240, 255, 255);
		elsif (result = WebColors.AliceBlue) then result = new Color(240, 248, 255);
		elsif (result = WebColors.GhostWhite) then result = new Color(248, 248, 255);
		elsif (result = WebColors.WhiteSmoke) then result = new Color(245, 245, 245);
		elsif (result = WebColors.SeaShell) then result = new Color(255, 245, 238);
		elsif (result = WebColors.Beige) then result = new Color(245, 245, 220);
		elsif (result = WebColors.OldLace) then result = new Color(253, 245, 230);
		elsif (result = WebColors.Cream) then result = new Color(255, 251, 240);
		elsif (result = WebColors.FloralWhite) then result = new Color(255, 250, 240);
		elsif (result = WebColors.Ivory) then result = new Color(255, 255, 240);
		elsif (result = WebColors.AntiqueWhite) then result = new Color(250, 235, 215);
		elsif (result = WebColors.Linen) then result = new Color(250, 240, 230);
		elsif (result = WebColors.LavenderBlush) then result = new Color(255, 240, 245);
		elsif (result = WebColors.MistyRose) then result = new Color(255, 228, 225);
		elsif (result = WebColors.Gainsboro) then result = new Color(220, 220, 220);
		elsif (result = WebColors.LightGray) then result = new Color(192, 192, 192);
		elsif (result = WebColors.Silver) then result = new Color(192, 192, 192);
		elsif (result = WebColors.DarkGray) then result = new Color(169, 169, 169);
		elsif (result = WebColors.MediumGray) then result = new Color(160, 160, 164);
		elsif (result = WebColors.Gray) then result = new Color(128, 128, 128);
		elsif (result = WebColors.DimGray) then result = new Color(105, 105, 105);
		elsif (result = WebColors.LightSlateGray) then result = new Color(119, 163, 153);
		elsif (result = WebColors.SlateGray) then result = new Color(112, 123, 144);
		elsif (result = WebColors.DarkSlateGray) then result = new Color(47, 79, 79);
		elsif (result = WebColors.Black) then result = new Color(0, 0, 0);
		elsif (result = WebColors.IndianRed) then result = new Color(205, 92, 92);
		elsif (result = WebColors.LightCoral) then result = new Color(240, 128, 128);
		elsif (result = WebColors.Salmon) then result = new Color(250, 128, 114);
		elsif (result = WebColors.DarkSalmon) then result = new Color(233, 150, 122);
		elsif (result = WebColors.LightSalmon) then result = new Color(255, 160, 122);
		elsif (result = WebColors.Crimson) then result = new Color(220, 20, 60);
		elsif (result = WebColors.Red) then result = new Color(255, 0, 0);
		elsif (result = WebColors.FireBrick) then result = new Color(178, 34, 34);
		elsif (result = WebColors.DarkRed) then result = new Color(139, 0, 0);
		elsif (result = WebColors.Pink) then result = new Color(255, 192, 203);
		elsif (result = WebColors.LightPink) then result = new Color(255, 182, 193);
		elsif (result = WebColors.HotPink) then result = new Color(255, 105, 180);
		elsif (result = WebColors.DeepPink) then result = new Color(255, 20, 147);
		elsif (result = WebColors.MediumVioletRed) then result = new Color(199, 21, 133);
		elsif (result = WebColors.VioletRed) then result = new Color(208, 32, 144);
		elsif (result = WebColors.PaleVioletRed) then result = new Color(219, 122, 147);
		elsif (result = WebColors.Coral) then result = new Color(255, 127, 80);
		elsif (result = WebColors.Tomato) then result = new Color(255, 99, 71);
		elsif (result = WebColors.OrangeRed) then result = new Color(255, 69, 0);
		elsif (result = WebColors.DarkOrange) then result = new Color(255, 140, 0);
		elsif (result = WebColors.Orange) then result = new Color(255, 165, 0);
		elsif (result = WebColors.Gold) then result = new Color(255, 215, 0);
		elsif (result = WebColors.Yellow) then result = new Color(255, 255, 0);
		elsif (result = WebColors.LightYellow) then result = new Color(255, 255, 224);
		elsif (result = WebColors.LemonChiffon) then result = new Color(255, 250, 205);
		elsif (result = WebColors.LightGoldenrodYellow) then result = new Color(250, 250, 210);
		elsif (result = WebColors.PapayaWhip) then result = new Color(255, 239, 213);
		elsif (result = WebColors.Moccasin) then result = new Color(255, 228, 181);
		elsif (result = WebColors.PeachPuff) then result = new Color(255, 218, 185);
		elsif (result = WebColors.PaleGoldenrod) then result = new Color(238, 232, 170);
		elsif (result = WebColors.Khaki) then result = new Color(240, 230, 140);
		elsif (result = WebColors.DarkKhaki) then result = new Color(189, 183, 107);
		elsif (result = WebColors.Lavender) then result = new Color(230, 230, 250);
		elsif (result = WebColors.Thistle) then result = new Color(216, 191, 216);
		elsif (result = WebColors.Plum) then result = new Color(221, 160, 221);
		elsif (result = WebColors.Violet) then result = new Color(238, 130, 238);
		elsif (result = WebColors.Orchid) then result = new Color(218, 112, 214);
		elsif (result = WebColors.Fuchsia) then result = new Color(255, 0, 255);
		elsif (result = WebColors.Magenta) then result = new Color(255, 0, 255);
		elsif (result = WebColors.MediumOrchid) then result = new Color(186, 85, 211);
		elsif (result = WebColors.MediumPurple) then result = new Color(147, 112, 219);
		elsif (result = WebColors.BlueViolet) then result = new Color(138, 43, 226);
		elsif (result = WebColors.DarkViolet) then result = new Color(148, 0, 211);
		elsif (result = WebColors.DarkOrchid) then result = new Color(153, 50, 204);
		elsif (result = WebColors.DarkMagenta) then result = new Color(139, 0, 139);
		elsif (result = WebColors.Purple) then result = new Color(128, 0, 128);
		elsif (result = WebColors.Indigo) then result = new Color(75, 0, 130);
		elsif (result = WebColors.LightSlateBlue) then result = new Color(132, 112, 255);
		elsif (result = WebColors.SlateBlue) then result = new Color(106, 90, 205);
		elsif (result = WebColors.DarkSlateBlue) then result = new Color(72, 61, 139);
		elsif (result = WebColors.MediumSlateBlue) then result = new Color(123, 104, 238);
		elsif (result = WebColors.GreenYellow) then result = new Color(173, 255, 47);
		elsif (result = WebColors.Chartreuse) then result = new Color(127, 255, 0);
		elsif (result = WebColors.LawnGreen) then result = new Color(124, 255, 0);
		elsif (result = WebColors.Lime) then result = new Color(0, 255, 0);
		elsif (result = WebColors.LimeGreen) then result = new Color(50, 205, 50);
		elsif (result = WebColors.PaleGreen) then result = new Color(152, 251, 152);
		elsif (result = WebColors.LightGreen) then result = new Color(144, 238, 144);
		elsif (result = WebColors.MediumSpringGreen) then result = new Color(0, 250, 154);
		elsif (result = WebColors.SpringGreen) then result = new Color(0, 255, 127);
		elsif (result = WebColors.MediumSeaGreen) then result = new Color(60, 179, 113);
		elsif (result = WebColors.Seagreen) then result = new Color(46, 139, 87);
		elsif (result = WebColors.ForestGreen) then result = new Color(34, 139, 34);
		elsif (result = WebColors.Green) then result = new Color(0, 128, 0);
		elsif (result = WebColors.MediumGreen) then result = new Color(192, 220, 192);
		elsif (result = WebColors.DarkGreen) then result = new Color(0, 100, 0);
		elsif (result = WebColors.YellowGreen) then result = new Color(154, 205, 50);
		elsif (result = WebColors.OliveDrab) then result = new Color(107, 142, 35);
		elsif (result = WebColors.Olive) then result = new Color(128, 128, 0);
		elsif (result = WebColors.DarkOliveGreen) then result = new Color(85, 107, 47);
		elsif (result = WebColors.MediumAquaMarine) then result = new Color(102, 205, 170);
		elsif (result = WebColors.DarkSeaGreen) then result = new Color(143, 188, 139);
		elsif (result = WebColors.LightSeaGreen) then result = new Color(32, 178, 170);
		elsif (result = WebColors.DarkCyan) then result = new Color(0, 139, 139);
		elsif (result = WebColors.Teal) then result = new Color(0, 128, 128);
		elsif (result = WebColors.Aqua) then result = new Color(0, 255, 255);
		elsif (result = WebColors.Cyan) then result = new Color(0, 255, 255);
		elsif (result = WebColors.LightCyan) then result = new Color(224, 255, 255);
		elsif (result = WebColors.PaleTurquoise) then result = new Color(175, 238, 238);
		elsif (result = WebColors.Aquamarine) then result = new Color(127, 255, 212);
		elsif (result = WebColors.Turquoise) then result = new Color(64, 224, 208);
		elsif (result = WebColors.MediumTurquoise) then result = new Color(72, 209, 204);
		elsif (result = WebColors.DarkTurquoise) then result = new Color(0, 206, 209);
		elsif (result = WebColors.CadetBlue) then result = new Color(95, 158, 160);
		elsif (result = WebColors.SteelBlue) then result = new Color(70, 130, 180);
		elsif (result = WebColors.LightSteelBlue) then result = new Color(176, 196, 222);
		elsif (result = WebColors.PowderBlue) then result = new Color(176, 224, 230);
		elsif (result = WebColors.LightBlue) then result = new Color(166, 202, 240);
		elsif (result = WebColors.SkyBlue) then result = new Color(135, 206, 235);
		elsif (result = WebColors.LightSkyBlue) then result = new Color(135, 206, 250);
		elsif (result = WebColors.DeepSkyBlue) then result = new Color(0, 191, 255);
		elsif (result = WebColors.DodgerBlue) then result = new Color(30, 144, 255);
		elsif (result = WebColors.CornFlowerBlue) then result = new Color(100, 149, 237);
		elsif (result = WebColors.RoyalBlue) then result = new Color(65, 105, 225);
		elsif (result = WebColors.Blue) then result = new Color(0, 0, 255);
		elsif (result = WebColors.MediumBlue) then result = new Color(0, 0, 205);
		elsif (result = WebColors.DarkBlue) then result = new Color(0, 0, 139);
		elsif (result = WebColors.Navy) then result = new Color(0, 0, 128);
		elsif (result = WebColors.MidnightBlue) then result = new Color(25, 25, 112);
		elsif (result = WebColors.CornSilk) then result = new Color(255, 248, 220);
		elsif (result = WebColors.BlanchedAlmond) then result = new Color(255, 235, 205);
		elsif (result = WebColors.Bisque) then result = new Color(255, 228, 196);
		elsif (result = WebColors.NavajoWhite) then result = new Color(255, 222, 173);
		elsif (result = WebColors.Wheat) then result = new Color(245, 222, 179);
		elsif (result = WebColors.BurlyWood) then result = new Color(222, 184, 135);
		elsif (result = WebColors.Tan) then result = new Color(210, 180, 140);
		elsif (result = WebColors.RosyBrown) then result = new Color(188, 143, 143);
		elsif (result = WebColors.SandyBrown) then result = new Color(244, 164, 96);
		elsif (result = WebColors.LightGoldenrod) then result = new Color(255, 236, 139);
		elsif (result = WebColors.Goldenrod) then result = new Color(218, 165, 32);
		elsif (result = WebColors.DarkGoldenRod) then result = new Color(184, 134, 11);
		elsif (result = WebColors.Peru) then result = new Color(205, 133, 63);
		elsif (result = WebColors.Chocolate) then result = new Color(210, 105, 30);
		elsif (result = WebColors.SaddleBrown) then result = new Color(139, 69, 19);
		elsif (result = WebColors.Sienna) then result = new Color(160, 82, 45);
		elsif (result = WebColors.Brown) then result = new Color(165, 42, 42);
		elsif (result = WebColors.Maroon) then result = new Color(128, 0, 0);
		endif;
	endif;

	// Преобразование.
	result = "#" + BringHex(result.B + result.G * 256 + result.R * 65536);
	
	return result;
	
КонецФункции // BringColor()

Функция BringHex(value)
	
	result = string(undefined); normalValue = Max(Int(value), 0); notation = 16; count = 6;

	while (normalValue > 0) do
		result = Mid("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ", normalValue % notation + 1, 1) + result;
		normalValue = Int(normalValue / notation);
	enddo;
	for index = StrLen(result) + 1 По count do
		result = "0" + result;
	enddo;

	return result;
	
КонецФункции // BringHex()
