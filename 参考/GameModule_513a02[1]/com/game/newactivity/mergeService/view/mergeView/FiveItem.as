package com.game.newactivity.mergeService.view.mergeView
{
    import __AS3__.vec.*;
    import com.cfg.*;
    import com.f1.*;
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.newactivity.control.*;
    import com.model.vo.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class FiveItem extends Component implements IItem
    {
        private var _info:NewActivityItemInfo;
        private var reqTxt:TextField;
        private var rewItems:Vector.<IconItem>;
        private var pickBtn:BaseButton;
        public static var DAY_INDEX:int;
        public static const MAX_REWARD_COUNT:int = 5;

        public function FiveItem()
        {
            var _loc_1:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            super("mergeServicePanel.fiveItem");
            this.reqTxt = getDisplayChildByName("reqTxt");
            this.pickBtn = new BaseButton(getDisplayChildByName("pickBtn"));
            this.rewItems = new Vector.<IconItem>(MAX_REWARD_COUNT, true);
            var _loc_2:* = 0;
            while (_loc_2 < MAX_REWARD_COUNT)
            {
                
                _loc_1 = getDisplayChildByName("rew" + _loc_2);
                _loc_3 = _loc_1.x;
                _loc_4 = _loc_1.y;
                _loc_5 = _loc_1.width;
                _loc_6 = _loc_1.height;
                _loc_7 = new IconItem(_loc_1);
                this.rewItems[_loc_2] = _loc_7;
                _loc_7.move(_loc_3, _loc_4);
                _loc_7.setWH(_loc_5, _loc_6);
                _loc_7.setImageSize(_loc_5, _loc_6);
                addChild(_loc_7);
                _loc_2++;
            }
            return;
        }// end function

        public function get key()
        {
            return null;
        }// end function

        public function get obj()
        {
            return null;
        }// end function

        public function set obj(param1) : void
        {
            this._info = param1;
            this.reqTxt.htmlText = this._info.condictionDes;
            if (this._info.canGet == ActivityStateCfg.UN_FINISH)
            {
                if (this._info.index == DAY_INDEX)
                {
                    this._info.canGet = ActivityStateCfg.ALLOW_PICK;
                }
            }
            if (this._info.canGet == ActivityStateCfg.ALLOW_PICK)
            {
                this.pickBtn.setText(LanguageCfgObj.getInstance().getByIndex("12424"));
                this.pickBtn.addEvtListener(MouseEvent.CLICK, this.onPickHandler);
                this.pickBtn.enabled = true;
            }
            else if (this._info.canGet == ActivityStateCfg.IS_PICKED)
            {
                this.pickBtn.setText(LanguageCfgObj.getInstance().getByIndex("12425"));
                this.pickBtn.removeEventListener(MouseEvent.CLICK, this.onPickHandler);
                this.pickBtn.enabled = false;
            }
            else if (this._info.canGet == ActivityStateCfg.MISSED_PICK)
            {
                this.pickBtn.setText(LanguageCfgObj.getInstance().getByIndex("12426"));
                this.pickBtn.removeEventListener(MouseEvent.CLICK, this.onPickHandler);
                this.pickBtn.enabled = false;
            }
            else if (this._info.canGet == ActivityStateCfg.UN_FINISH)
            {
                if (this._info.index >= DAY_INDEX)
                {
                    this.pickBtn.setText(StringUtil.formatString(LanguageCfgObj.getInstance().getByIndex("12428"), StringUtil.formatString("<font color=\'#ff0000\'>{0}</font>", this._info.index - DAY_INDEX)));
                }
                else
                {
                    this.pickBtn.setText(LanguageCfgObj.getInstance().getByIndex("12426"));
                }
                this.pickBtn.removeEventListener(MouseEvent.CLICK, this.onPickHandler);
                this.pickBtn.enabled = false;
            }
            this.updateItems();
            return;
        }// end function

        private function updateItems() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < MAX_REWARD_COUNT)
            {
                
                _loc_2 = this.rewItems[_loc_1];
                _loc_3 = this._info.awardList[_loc_1];
                _loc_2.setInfo(_loc_3);
                _loc_2.visible = _loc_3 != null;
                _loc_1++;
            }
            return;
        }// end function

        public function get label() : String
        {
            return null;
        }// end function

        public function setSelected(param1:Boolean, param2:Boolean = true) : void
        {
            return;
        }// end function

        public function get selected() : Boolean
        {
            return false;
        }// end function

        override public function finalize() : void
        {
            var _loc_2:* = null;
            this._info = null;
            this.reqTxt = null;
            this.pickBtn.removeEventListener(MouseEvent.CLICK, this.onPickHandler);
            this.pickBtn.finalize();
            this.pickBtn = null;
            var _loc_1:* = 0;
            while (_loc_1 < MAX_REWARD_COUNT)
            {
                
                _loc_2 = this.rewItems[_loc_1];
                _loc_2.finalize();
                _loc_1++;
            }
            this.rewItems = null;
            super.finalize();
            return;
        }// end function

        private function onPickHandler(event:MouseEvent) : void
        {
            NewActivityControl.getInstance().getActivityReward(this._info.activityId, this._info.index);
            return;
        }// end function

    }
}
