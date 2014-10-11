package com.game.bank.view
{
    import com.f1.*;
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.utils.*;
    import com.model.vo.*;
    import flash.events.*;
    import flash.text.*;

    public class BankHistoryItem extends BaseButton implements IItem
    {
        private var txt:TextField;
        private var _info:Object;
        private var _personId:long;
        private var _personName:String;

        public function BankHistoryItem(param1:String = "bankHistoryItem")
        {
            super(param1);
            this.txt = getDisplayChildByName("txt");
            this.txt.mouseWheelEnabled = false;
            this.txt.multiline = true;
            this.txt.wordWrap = true;
            this.mouseChildren = true;
            this.txt.mouseEnabled = true;
            this.txt.autoSize = TextFieldAutoSize.LEFT;
            return;
        }// end function

        override public function get key()
        {
            return this._info.label;
        }// end function

        public function get info()
        {
            return this._info;
        }// end function

        override public function set obj(param1) : void
        {
            if (!param1)
            {
                return;
            }
            super.obj = param1;
            this.setInfo(param1, true);
            return;
        }// end function

        public function refresh() : void
        {
            this.setInfo(obj, true);
            return;
        }// end function

        private function setInfo(param1:Object, param2:Boolean = false) : void
        {
            var _loc_3:* = null;
            if (this._info != param1 || param2)
            {
                this._info = param1;
                if (this._info)
                {
                    if (param1.option <= 1)
                    {
                        if (param1.option == 0 || param1.option == 2)
                        {
                            _loc_3 = LanguageCfgObj.getInstance().getByIndex("11926");
                        }
                        else
                        {
                            _loc_3 = LanguageCfgObj.getInstance().getByIndex("11927");
                        }
                    }
                    else if (param1.option == 0 || param1.option == 2)
                    {
                        _loc_3 = LanguageCfgObj.getInstance().getByIndex("11928");
                    }
                    else
                    {
                        _loc_3 = LanguageCfgObj.getInstance().getByIndex("11929");
                    }
                    this.txt.htmlText = StringUtil.languageReplace(_loc_3, ["<font color=\'#00ff00\'>" + param1.playerName + "</font>", param1.count]);
                }
            }
            return;
        }// end function

        private function __click(event:MouseEvent) : void
        {
            return;
        }// end function

        private function __click2(event:TextEvent) : void
        {
            var _loc_2:* = new PlayerInfo();
            _loc_2.personId = this._personId;
            _loc_2.name = this._personName;
            return;
        }// end function

    }
}
