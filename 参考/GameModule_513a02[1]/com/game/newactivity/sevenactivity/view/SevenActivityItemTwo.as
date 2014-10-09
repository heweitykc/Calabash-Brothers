package com.game.newactivity.sevenactivity.view
{
    import com.f1.*;
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.game.newactivity.control.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import com.view.tipcell.*;
    import flash.events.*;
    import flash.text.*;

    public class SevenActivityItemTwo extends Component implements IItem
    {
        private var condictionText:TextField;
        private var link:BaseButton;
        private var awardBtn:BaseButton;
        private var _isInitAward:Boolean = false;
        private var _obj:NewActivityItemInfo;

        public function SevenActivityItemTwo()
        {
            super("sevenTargetItem2");
            this.awardBtn = new BaseButton(getDisplayChildByName("awardBtn"));
            this.link = new BaseButton(getDisplayChildByName("link"));
            this.link.visible = false;
            this.condictionText = getDisplayChildByName("condiction") as TextField;
            return;
        }// end function

        public function set obj(param1) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (!param1)
            {
                return;
            }
            this._obj = param1;
            if (!this._isInitAward)
            {
                _loc_2 = 0;
                _loc_3 = this._obj.jobAwardList.length;
                _loc_5 = 256;
                while (_loc_2 < _loc_3)
                {
                    
                    if (!PropUtil.isEquip(this._obj.jobAwardList[_loc_2].q_type))
                    {
                        _loc_4 = new IconItem("commonRewardBox2_40");
                        _loc_4.setImageXY(4, 4);
                        _loc_4.setWH(48, 48);
                        _loc_4.setCountTxtXY(48 - 7, 48 - 18);
                        _loc_4.x = _loc_5;
                        _loc_4.y = 17;
                        _loc_5 = _loc_5 + 50;
                    }
                    else
                    {
                        _loc_4 = new IconItem("PropBox66");
                        _loc_4.setImageXY(6, 6);
                        _loc_4.setImageSize(56, 56);
                        _loc_4.setCountTxtXY(56 - 7, 56 - 18);
                        _loc_4.setWH(66, 66);
                        _loc_4.x = _loc_5;
                        _loc_4.y = 8;
                        _loc_5 = _loc_5 + 68;
                    }
                    _loc_4.setInfo(this._obj.jobAwardList[_loc_2]);
                    addChild(_loc_4);
                    _loc_2++;
                }
                _loc_6 = this._obj.getStrCondiction();
                _loc_7 = this._obj.condictionDes;
                _loc_2 = 0;
                _loc_3 = _loc_6.length;
                while (_loc_2 < _loc_3)
                {
                    
                    _loc_7 = _loc_7.replace("%", _loc_6[_loc_2]);
                    _loc_2++;
                }
                this.condictionText.htmlText = _loc_7;
                if (this._obj.index < 2)
                {
                    this.link.visible = true;
                    ItemTips.create(this.link, this._obj, SevenActTips);
                }
                this.link.addEventListener(MouseEvent.MOUSE_OVER, this.__over);
                this._isInitAward = true;
            }
            if (this._obj.canGet == 0)
            {
                this.awardBtn.enabled = false;
                this.awardBtn.filters = [FrameworkGlobal.colorMat];
                this.awardBtn.removeEventListener(MouseEvent.CLICK, this.__getAward);
            }
            else
            {
                this.awardBtn.enabled = true;
                this.awardBtn.filters = null;
                this.awardBtn.addEventListener(MouseEvent.CLICK, this.__getAward);
            }
            return;
        }// end function

        private function __over(event:MouseEvent) : void
        {
            if (this._obj)
            {
                NewActivityControl.getInstance().getActivityRankInfo(this._obj.activityId);
            }
            return;
        }// end function

        private function __getAward(event:MouseEvent) : void
        {
            NewActivityControl.getInstance().getActivityReward(this._obj.activityId, this._obj.index);
            return;
        }// end function

        public function get key()
        {
            return null;
        }// end function

        public function get obj()
        {
            return this._obj;
        }// end function

        public function get label() : String
        {
            return null;
        }// end function

        public function get selected() : Boolean
        {
            return false;
        }// end function

        public function setSelected(param1:Boolean, param2:Boolean = true) : void
        {
            return;
        }// end function

    }
}
