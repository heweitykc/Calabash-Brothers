package com.game.newactivity.singlerecharge.view
{
    import com.f1.*;
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.game.newactivity.control.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;

    public class SingleRechargeItem extends Component implements IItem
    {
        private var _numArray:Array;
        private var _awardArray:Array;
        private var _awardBtn:BaseButton;
        private var _obj:NewActivityItemInfo;
        private const TOTAL_NUM:int = 5;
        private const TOTAL_AWARD_ICON:int = 5;

        public function SingleRechargeItem()
        {
            super("singleRechargeItem");
            this._awardBtn = new BaseButton(getDisplayChildByName("getAwardBtn"));
            return;
        }// end function

        public function get key()
        {
            return null;
        }// end function

        public function set obj(param1) : void
        {
            if (!param1)
            {
                return;
            }
            this._obj = param1 as NewActivityItemInfo;
            this.initAward();
            this._initCondiction();
            this.resetGetBtn();
            return;
        }// end function

        public function resetAllInfoByObj(param1) : void
        {
            if (!param1)
            {
                return;
            }
            this._obj = param1 as NewActivityItemInfo;
            this.initAward(true);
            this._initCondiction(true);
            this.resetGetBtn();
            return;
        }// end function

        private function resetGetBtn() : void
        {
            if (this._obj.canGet == 0)
            {
                this._awardBtn.filters = [FrameworkGlobal.colorMat];
                this._awardBtn.enabled = false;
                this._awardBtn.removeEventListener(MouseEvent.CLICK, this.__getAward);
            }
            else
            {
                this._awardBtn.filters = null;
                this._awardBtn.enabled = true;
                this._awardBtn.addEventListener(MouseEvent.CLICK, this.__getAward);
            }
            return;
        }// end function

        private function initAward(param1:Boolean = false) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            if (param1 && this._awardArray && this._awardArray.length)
            {
                for each (_loc_2 in this._awardArray)
                {
                    
                    _loc_2.finalize();
                    if (contains(_loc_2))
                    {
                        removeChild(_loc_2);
                    }
                }
                this._awardArray = null;
            }
            if (!this._awardArray)
            {
                this._awardArray = [];
                _loc_5 = 0;
                for each (_loc_4 in this._obj.jobAwardList)
                {
                    
                    _loc_3 = new IconItem("commonRewardBox2_40");
                    _loc_3.setImageXY(4, 4);
                    _loc_3.setWH(48, 48);
                    _loc_3.x = 111 + _loc_5 * 53;
                    _loc_3.y = 6;
                    _loc_3.setCountTxtXY(48 - 7, 48 - 18);
                    _loc_3.setInfo(_loc_4);
                    addChild(_loc_3);
                    this._awardArray.push(_loc_3);
                    _loc_5++;
                }
                while (_loc_5 < this.TOTAL_AWARD_ICON)
                {
                    
                    _loc_3 = new IconItem("commonRewardBox2_40");
                    _loc_3.setImageXY(4, 4);
                    _loc_3.setWH(48, 48);
                    _loc_3.setCountTxtXY(48 - 7, 48 - 18);
                    _loc_3.x = 111 + _loc_5 * 53;
                    _loc_3.y = 6;
                    addChild(_loc_3);
                    this._awardArray.push(_loc_3);
                    _loc_5++;
                }
            }
            return;
        }// end function

        private function _initCondiction(param1:Boolean = false) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            if (!this._numArray || param1)
            {
                if (!this._numArray)
                {
                    this._numArray = [];
                    _loc_5 = 0;
                    _loc_5 = 0;
                    while (_loc_5 < this.TOTAL_NUM)
                    {
                        
                        _loc_4 = getDisplayChildByName("num_" + _loc_5) as MovieClip;
                        this._numArray.push(_loc_4);
                        _loc_5++;
                    }
                }
                _loc_3 = 0;
                _loc_5 = this._obj.condiction.length - 1;
                while (_loc_5 >= 0)
                {
                    
                    _loc_2 = int(this._obj.condiction.charAt(_loc_3));
                    this._numArray[_loc_5].gotoAndStop((_loc_2 + 1));
                    this._numArray[_loc_5].visible = true;
                    _loc_3++;
                    _loc_5 = _loc_5 - 1;
                }
                _loc_5 = this._obj.condiction.length;
                while (_loc_5 < this.TOTAL_NUM)
                {
                    
                    this._numArray[_loc_5].visible = false;
                    _loc_5++;
                }
            }
            return;
        }// end function

        private function __getAward(event:MouseEvent) : void
        {
            NewActivityControl.getInstance().getActivityReward(NewActivityConfig.ACTID_SINGLE_RECHARGE, this._obj.index);
            return;
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
