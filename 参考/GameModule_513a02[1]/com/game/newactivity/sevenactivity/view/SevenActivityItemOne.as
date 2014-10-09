package com.game.newactivity.sevenactivity.view
{
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

    public class SevenActivityItemOne extends Component implements IItem
    {
        private var equipMark:MovieClip;
        private var awardBtn:BaseButton;
        private var plusArr:Array;
        private var iconList:Array;
        private var _obj:NewActivityItemInfo;

        public function SevenActivityItemOne()
        {
            super("sevenTargetItem1");
            this.awardBtn = new BaseButton(getDisplayChildByName("awardBtn"));
            this.equipMark = getDisplayChildByName("equipMark") as MovieClip;
            return;
        }// end function

        public function set obj(param1) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (!param1)
            {
                return;
            }
            this._obj = param1 as NewActivityItemInfo;
            if (!this.iconList)
            {
                this.plusArr = [];
                this.iconList = [];
                _loc_2 = this._obj.getItemCondiction();
                _loc_4 = 21;
                _loc_5 = 0;
                _loc_6 = _loc_2.length;
                while (_loc_5 < _loc_6)
                {
                    
                    if (_loc_5 != 0)
                    {
                        _loc_8 = new Bitmap(ToolKit.getNew("sevenActivityViewPlus") as BitmapData);
                        _loc_8.x = _loc_4;
                        _loc_8.y = 30;
                        addChild(_loc_8);
                        this.plusArr.push(_loc_8);
                        _loc_4 = _loc_4 + (_loc_8.width - 1);
                    }
                    _loc_3 = _loc_2[_loc_5];
                    _loc_7 = new IconItem("commonRewardBox2_40");
                    _loc_7.setImageXY(4, 4);
                    _loc_7.setWH(48, 48);
                    _loc_7.setCountTxtXY(48 - 7, 48 - 18);
                    _loc_7.y = 16;
                    _loc_7.x = _loc_4;
                    _loc_7.setInfo(_loc_3);
                    addChild(_loc_7);
                    this.iconList.push(_loc_7);
                    _loc_4 = _loc_4 + 47;
                    _loc_5++;
                }
                this.equipMark.x = _loc_4;
                _loc_4 = _loc_4 + (this.equipMark.width - 1);
                _loc_6 = this._obj.jobAwardList.length;
                _loc_5 = 0;
                while (_loc_5 < _loc_6)
                {
                    
                    _loc_7 = new IconItem("commonRewardBox2_40");
                    _loc_7.setImageXY(4, 4);
                    _loc_7.setWH(48, 48);
                    _loc_7.setCountTxtXY(48 - 7, 48 - 18);
                    _loc_7.x = _loc_4;
                    _loc_7.y = 16;
                    _loc_7.setInfo(this._obj.jobAwardList[_loc_5]);
                    addChild(_loc_7);
                    this.iconList.push(_loc_7);
                    _loc_4 = _loc_4 + 49;
                    _loc_5++;
                }
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

        override public function finalize() : void
        {
            this.awardBtn.removeEventListener(MouseEvent.CLICK, this.__getAward);
            this.awardBtn.finalize();
            var _loc_1:* = 0;
            var _loc_2:* = this.plusArr.length;
            while (_loc_1 < _loc_2)
            {
                
                removeChild(this.plusArr[_loc_1]);
                _loc_1++;
            }
            this.plusArr.length = 0;
            _loc_2 = this.iconList.length;
            while (_loc_1 < _loc_2)
            {
                
                removeChild(this.iconList[_loc_1]);
                this.iconList[_loc_1].setInfo(null);
                this.iconList[_loc_1].finalize();
                this.iconList[_loc_1] = null;
                _loc_1++;
            }
            this.iconList.length = 0;
            super.finalize();
            return;
        }// end function

    }
}
