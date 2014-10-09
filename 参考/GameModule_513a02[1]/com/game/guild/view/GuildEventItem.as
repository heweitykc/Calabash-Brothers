package com.game.guild.view
{
    import com.f1.*;
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.backpack.view.*;
    import com.game.utils.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class GuildEventItem extends BaseButton implements IItem
    {
        private var txt:TextField;
        private var bg:MovieClip;
        private var _info:Object;
        private var _personId:long;
        private var _personName:String;

        public function GuildEventItem(param1:String = "guildEventItem")
        {
            super(param1);
            this.txt = getDisplayChildByName("txt");
            this.txt.mouseWheelEnabled = false;
            this.txt.multiline = true;
            this.txt.wordWrap = true;
            this.bg = getDisplayChildByName("mc");
            this.bg.visible = false;
            this.mouseChildren = true;
            this.txt.mouseEnabled = true;
            this.txt.width = this.bg.width;
            this.txt.autoSize = TextFieldAutoSize.LEFT;
            return;
        }// end function

        override public function get key()
        {
            return this._info.label;
        }// end function

        public function set select(param1:Boolean) : void
        {
            if (param1)
            {
                this.bg.gotoAndStop(2);
            }
            else
            {
                this.bg.gotoAndStop(1);
            }
            return;
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
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (this._info != param1 || param2)
            {
                this._info = param1;
                if (this._info)
                {
                    _loc_3 = param1.message;
                    if (_loc_3.indexOf("number") == -1)
                    {
                        _loc_4 = 0;
                    }
                    else
                    {
                        _loc_4 = 5;
                    }
                    _loc_5 = new Object();
                    _loc_6 = _loc_3.split(",");
                    if (_loc_4)
                    {
                        _loc_5.number1 = _loc_6[1].substring(11, _loc_6[1].length);
                        _loc_5.number2 = _loc_6[2];
                        _loc_5.number3 = _loc_6[3];
                        _loc_5.number4 = _loc_6[4];
                        _loc_5.number5 = _loc_6[5].substring(0, _loc_6[5].length - 2);
                    }
                    if (_loc_3.indexOf("name") != -1)
                    {
                        _loc_5.name = _loc_6[0].substring(16, (_loc_6[0].length - 1));
                        this._personName = _loc_5.name;
                        _loc_5.pid = _loc_6[1 + _loc_4].substring(7, (_loc_6[1 + _loc_4].length - 1));
                        this._personId = long.parselong(_loc_5.pid);
                        _loc_5.type = _loc_6[2 + _loc_4].substring(7, _loc_6[2 + _loc_4].length - 2);
                        _loc_5.t = _loc_6[3 + _loc_4].substring(5, _loc_6[3 + _loc_4].length - 2);
                        _loc_7 = "<font color=\'#00ff00\'><a href=\'event:click\'><u>" + _loc_5.name + "</u></a></font>";
                        _loc_5.t = (_loc_5.t as String).replace("{@}", _loc_7);
                    }
                    else
                    {
                        _loc_5.t = _loc_6[1].substring(5, _loc_6[1].length - 2);
                    }
                    this.txt.htmlText = "[" + ToolKit.parseSecond3Date(param1.messageTime) + "]: " + _loc_5.t;
                    this.bg.height = this.txt.height + 5;
                    this.setWH(this.bg.width, this.bg.height);
                    this.txt.addEventListener(TextEvent.LINK, this.__click2);
                    addEvtListener(MouseEvent.CLICK, this.__click);
                    addEvtListener("rightClick", this.__click);
                    addEvtListener(MouseEvent.DOUBLE_CLICK, this.__click);
                }
                else
                {
                    removeEvtListener(MouseEvent.CLICK, this.__click);
                    removeEvtListener("rightClick", this.__click);
                    removeEvtListener(MouseEvent.DOUBLE_CLICK, this.__click);
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
            ItemPopMenu.instance.show(null, FrameworkGlobal.stage, 0, 0, ItemPopMenu.GUILD, _loc_2);
            return;
        }// end function

    }
}
