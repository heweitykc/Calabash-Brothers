package com.view
{
    import com.f1.structs.*;
    import com.f1.ui.btn.*;
    import flash.display.*;
    import flash.text.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class McTrace extends Object
    {
        public static var topPanelName:Array = ["SubHeroPanel", "BagPanel", "GuildPanel", "EquipPanel", "EquipReelPanel", "SweepPanel", "HeroClubPanel", "TaskPanel", "TaskTracePanel", "QnaPanel", "WarPanel", "ShopPanel", "GuildListPanel", "SecretStorePanel"];

        public function McTrace()
        {
            return;
        }// end function

        public static function getDisplayObjectFolder(param1:Object) : String
        {
            return getEveryFolder(param1);
        }// end function

        public static function getEveryFolder(param1:Object) : String
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = false;
            var _loc_6:* = false;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_2:* = "";
            if (param1 is DisplayObject)
            {
                _loc_3 = param1 as DisplayObject;
                _loc_4 = "";
                _loc_5 = true;
                if (_loc_3 is Stage)
                {
                    _loc_2 = "Stage";
                }
                else
                {
                    _loc_8 = getNameByClass(_loc_3);
                    _loc_2 = _loc_8.txtName;
                    _loc_4 = _loc_8.className;
                    _loc_5 = _loc_8.needFlow;
                }
                _loc_6 = false;
                for each (_loc_7 in topPanelName)
                {
                    
                    if (_loc_7 == _loc_4)
                    {
                        _loc_6 = true;
                    }
                }
                if (_loc_3.parent == null || _loc_6 || !_loc_5)
                {
                    return _loc_2 + "(x:" + _loc_3.mouseX + " y:" + _loc_3.mouseY + ")";
                }
                return getEveryFolder(_loc_3.parent) + "/" + _loc_2;
            }
            return _loc_2;
        }// end function

        public static function getNameByClass(param1:DisplayObject) : NameCell
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_2:* = getQualifiedClassName(param1);
            var _loc_3:* = _loc_2.split("::");
            var _loc_4:* = "";
            if (_loc_3.length == 1)
            {
                _loc_4 = _loc_2;
            }
            if (_loc_3.length == 2)
            {
                _loc_4 = _loc_3[1] as String;
            }
            switch(getQualifiedClassName(param1))
            {
                case "com.f1.ui.btn::BaseButton":
                {
                    _loc_5 = param1 as BaseButton;
                    if (_loc_5.name == "talkBoxFuncBtn")
                    {
                        return new NameCell("对话:" + _loc_5.getText(), _loc_4, false);
                    }
                    _loc_6 = _loc_5.getDisplay() as Object;
                    if (_loc_6.hasOwnProperty("txt"))
                    {
                        return new NameCell("按钮:" + _loc_6["txt"]["text"], _loc_4);
                    }
                    if (_loc_5.hasOwnProperty("_name") && _loc_5["_name"] && _loc_5["_name"] != "")
                    {
                        return new NameCell("按钮:" + _loc_5["_name"], _loc_4);
                    }
                    return new NameCell(_loc_5.name, _loc_4);
                }
                case "dailyCellMc":
                {
                    return new NameCell(param1["taskName"]["text"], _loc_4, false);
                }
                case "talkBoxFuncBtn":
                {
                    return new NameCell(param1["taskName"]["text"], _loc_4, false);
                }
                case "flash.display::SimpleButton":
                {
                    return new NameCell(param1["name"], _loc_4);
                }
                case "flash.text::TextField":
                {
                    _loc_7 = param1 as TextField;
                    return new NameCell(_loc_7.text, _loc_4);
                }
                case "com.game.role::Role":
                {
                    _loc_8 = param1 as IRole;
                    return new NameCell("Role:" + _loc_8.info.url, _loc_4);
                }
                default:
                {
                    break;
                }
            }
            return new NameCell(_loc_4, _loc_4);
        }// end function

    }
}
