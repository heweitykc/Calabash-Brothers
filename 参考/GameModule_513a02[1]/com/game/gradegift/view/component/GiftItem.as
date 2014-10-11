package com.game.gradegift.view.component
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.utils.*;
    import com.game.clickstream.*;
    import com.game.gradegift.control.*;
    import com.game.gradegift.model.*;
    import com.game.prompt.utils.*;
    import com.model.*;
    import com.util.*;
    import com.view.icon.*;
    import com.view.ui.list.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;

    public class GiftItem extends ListItem
    {
        private var _getBtn:BaseButton;
        private var _needLevelTxt:TextField;
        private var _remainTxt:TextField;
        private var _hbox40:HBox;
        private var _hbox56:HBox;
        private var _giftInfo:GiftInfo;

        public function GiftItem(param1:String = "levelRewards_contentItem2", param2:String = "")
        {
            super(param1, param2);
            return;
        }// end function

        override protected function getComp() : void
        {
            this._getBtn = new BaseButton(_content.getChildByName("getBtn"));
            this._getBtn.setText(LanguageCfgObj.getInstance().getByIndex("10714"));
            this._getBtn.addEvtListener(MouseEvent.CLICK, this.__reqGetItem);
            this._needLevelTxt = _content.getChildByName("needLevel") as TextField;
            this._remainTxt = _content.getChildByName("remainTxt") as TextField;
            this._hbox40 = new HBox();
            this._hbox40.oneRow = 0;
            this._hbox40.intervalX = 3;
            this._hbox40.horizontal = true;
            this._hbox40.move(14, 40);
            this._hbox56 = new HBox();
            this._hbox56.horizontal = true;
            this._hbox56.oneRow = 0;
            this._hbox56.y = 30;
            this._hbox56.intervalX = 3;
            addChild(this._hbox40);
            addChild(this._hbox56);
            return;
        }// end function

        public function update(param1:GiftInfo) : void
        {
            var _loc_2:* = null;
            this._giftInfo = param1;
            _loc_2 = QGradeGiftCfgObj.getInstance().getGradeGift(param1.giftId);
            if (UserObj.getInstance().playerInfo.level >= _loc_2.q_need_grade)
            {
                this._getBtn.enabled = true;
                this._needLevelTxt.htmlText = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12050"), ["<font color = \'#1cc749\'>" + _loc_2.q_need_grade + "</font>"]);
            }
            else
            {
                this._getBtn.enabled = false;
                this._needLevelTxt.htmlText = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12050"), ["<font color = \'#ff0000\'>" + _loc_2.q_need_grade + "</font>"]);
            }
            if (param1.remain < 0)
            {
                this._remainTxt.htmlText = LanguageCfgObj.getInstance().getByIndex("10715");
            }
            else if (param1.remain == 0)
            {
                this._remainTxt.htmlText = LanguageCfgObj.getInstance().getByIndex("10716");
            }
            else
            {
                this._remainTxt.htmlText = LanguageCfgObj.getInstance().getByIndex("12051") + " <font color = \'#1cc749\'>" + param1.remain + "</font>";
            }
            if (param1.isGain <= 0)
            {
                this._getBtn.setText(LanguageCfgObj.getInstance().getByIndex("10714"));
            }
            else
            {
                this._getBtn.setText(LanguageCfgObj.getInstance().getByIndex("10718"));
                this._getBtn.enabled = false;
            }
            return;
        }// end function

        override protected function receive() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = obj;
            this._hbox40.reset();
            this._hbox56.reset();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_1.length)
            {
                
                if (PropUtil.isEquip(_loc_1[_loc_3].q_type))
                {
                    _loc_2 = new GiftIconItem("PropBox66");
                    _loc_2.setWH(66, 66);
                    _loc_2.setInfo(_loc_1[_loc_3]);
                    this._hbox56.add(_loc_2);
                }
                else
                {
                    _loc_2 = new GiftIconItem("commonRewardBox2_40");
                    _loc_2.setWH(48, 48);
                    _loc_2.setInfo(_loc_1[_loc_3]);
                    this._hbox40.add(_loc_2);
                }
                _loc_3++;
            }
            this._hbox56._x = this._hbox40._x + this._hbox40.width;
            return;
        }// end function

        private function __reqGetItem(event:MouseEvent) : void
        {
            ClickStream.add(ClickStreamId.CLICK_DengJiJiangLi_LingQuJiangLi);
            GradeGiftControl.getInstance().reqGainGift(this._giftInfo.giftId);
            return;
        }// end function

        public function pack() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            _loc_1 = this._hbox40.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_1)
            {
                
                _loc_2 = this._hbox40.getContent(_loc_3) as GiftIconItem;
                ItemGetAnim.doFlyToBackPack(_loc_2.info.q_id, _loc_2.localToGlobal(new Point(0, 0)));
                _loc_3++;
            }
            _loc_1 = this._hbox56.length;
            _loc_3 = 0;
            while (_loc_3 < _loc_1)
            {
                
                _loc_2 = this._hbox56.getContent(_loc_3) as GiftIconItem;
                ItemGetAnim.doFlyToBackPack(_loc_2.info.q_id, _loc_2.localToGlobal(new Point(0, 0)));
                _loc_3++;
            }
            return;
        }// end function

        override public function finalize() : void
        {
            this._getBtn.removeEvtListener(MouseEvent.CLICK, this.__reqGetItem);
            super.finalize();
            return;
        }// end function

    }
}
