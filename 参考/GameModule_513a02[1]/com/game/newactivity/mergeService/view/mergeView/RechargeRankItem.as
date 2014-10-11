package com.game.newactivity.mergeService.view.mergeView
{
    import com.f1.ui.*;
    import com.model.vo.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.text.*;

    public class RechargeRankItem extends Component
    {
        private var _mark_1:MovieClip;
        private var _rewardItem:IconItem;
        private var _playerTxt:TextField;

        public function RechargeRankItem(param1 = null, param2:String = null)
        {
            super(param1, param2);
            this._mark_1 = getDisplayChildByName("mark_1");
            this._mark_1.mouseChildren = false;
            this._mark_1.mouseEnabled = false;
            this._playerTxt = getDisplayChildByName("playerTxt");
            this._playerTxt.text = "";
            var _loc_3:* = getDisplayChildByName("rew0");
            var _loc_4:* = _loc_3.x;
            var _loc_5:* = _loc_3.y;
            var _loc_6:* = _loc_3.width;
            var _loc_7:* = _loc_3.height;
            var _loc_8:* = _loc_3.parent.getChildIndex(_loc_3);
            this._rewardItem = new IconItem(_loc_3);
            this._rewardItem.move(_loc_4, _loc_5);
            this._rewardItem.setImageXY(6, 6);
            this._rewardItem.setImageSize(56, 56);
            this._rewardItem.setCountTxtXY(56 - 7, 56 - 18);
            this._rewardItem.setWH(66, 66);
            addChildAt(this._rewardItem, _loc_8);
            return;
        }// end function

        public function setInfo(param1:NewActivityItemInfo) : void
        {
            if (!param1)
            {
                visible = false;
                return;
            }
            visible = true;
            this._rewardItem.setInfo(param1.jobAwardList[0]);
            return;
        }// end function

        public function clearInfo() : void
        {
            return;
        }// end function

        public function setPlayerName(param1:String) : void
        {
            if (param1)
            {
                this._playerTxt.text = param1;
            }
            else
            {
                this._playerTxt.text = "";
            }
            return;
        }// end function

        public function setCostData(param1:String) : void
        {
            return;
        }// end function

    }
}
