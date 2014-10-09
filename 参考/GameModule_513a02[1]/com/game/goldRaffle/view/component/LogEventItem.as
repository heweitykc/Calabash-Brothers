package com.game.goldRaffle.view.component
{
    import com.adobe.serialization.json.*;
    import com.f1.*;
    import com.game.backpack.control.*;
    import com.game.backpack.view.*;
    import com.game.goldRaffle.bean.*;
    import com.game.utils.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.tipcell.*;
    import com.view.ui.list.*;
    import flash.events.*;
    import flash.text.*;

    public class LogEventItem extends ListItem
    {
        private var logTxt:TextField;
        private var nameTxt:TextField;
        private var itemTxt:TextField;
        private var itemInfo:Object;
        private var _equipInfo:PropInfo;
        private var tip:BaseTips;

        public function LogEventItem()
        {
            super("goldRaffles_eventItem", "");
            return;
        }// end function

        override protected function getComp() : void
        {
            this.logTxt = _content.getChildByName("txt") as TextField;
            this.logTxt.mouseWheelEnabled = false;
            this.logTxt.multiline = true;
            this.logTxt.wordWrap = true;
            this.addChild(this.logTxt);
            this.logTxt.addEventListener(MouseEvent.MOUSE_OUT, this.__moveout);
            return;
        }// end function

        override protected function receive() : void
        {
            var _loc_1:* = obj as GoldRaffleEventInfo;
            if (!_loc_1)
            {
                return;
            }
            var _loc_2:* = _loc_1.message;
            this.itemInfo = JSON.decode(_loc_2);
            this._equipInfo = PropUtil.createItemByJson(this.itemInfo.ps[1]);
            var _loc_3:* = "<font color=\'#13a400\'><a href=\'event:click1\'><u>" + this.itemInfo.ps[0].name + "</u></a></font><font color=\'#8c774f\'>";
            this.itemInfo.t = (this.itemInfo.t as String).replace("{@}", _loc_3);
            var _loc_4:* = PropUtil.getEquipNameAndColor(this._equipInfo);
            _loc_3 = "</font><font color=\'#" + (_loc_4[1] as int).toString(16) + "\'><a href=\'event:click2\'><u>" + _loc_4[0] + "</u></a></font>";
            this.itemInfo.t = (this.itemInfo.t as String).replace("{@}", _loc_3);
            this.logTxt.htmlText = this.itemInfo.t;
            this.logTxt.addEventListener(TextEvent.LINK, this.__click);
            return;
        }// end function

        private function __click(event:TextEvent) : void
        {
            var _loc_2:* = null;
            if (event.text == "click2")
            {
                this.tip = EquipCompareControl.createEquipTips(this._equipInfo);
            }
            else if (event.text == "click1")
            {
                _loc_2 = new RoleInfo();
                _loc_2.personId = long.parselong(this.itemInfo.ps[0].pid);
                _loc_2.name = this.itemInfo.ps[0].name;
                ItemPopMenu.instance.show(null, FrameworkGlobal.stage, 0, 0, ItemPopMenu.GUILD, _loc_2);
            }
            return;
        }// end function

        private function __moveout(event:MouseEvent) : void
        {
            if (this.tip)
            {
                EquipCompareControl.removeTips(this.tip);
                this.tip = null;
            }
            return;
        }// end function

    }
}
