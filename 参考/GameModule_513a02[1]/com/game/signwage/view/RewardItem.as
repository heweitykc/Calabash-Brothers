package com.game.signwage.view
{
    import com.f1.utils.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.display.*;

    public class RewardItem extends IconItem
    {
        private var _statusImg:DisplayObject;

        public function RewardItem(param1:String)
        {
            var _loc_3:* = null;
            super("signup.comRewardIcon");
            var _loc_2:* = param1.split(":");
            _loc_3 = PropUtil.getItemInfoByString(_loc_2[0]);
            _loc_3.num = int(_loc_2[1]);
            _loc_3.isbind = _loc_2.pop();
            _countTxt.x = this.width - 7;
            image.move(3, 3);
            setImageSize(40, 40);
            setInfo(_loc_3);
            this.addLock(_loc_3.isbind == 1);
            return;
        }// end function

        private function addLock(param1:Boolean) : void
        {
            if (param1)
            {
                this._statusImg = ToolKit.getNewDO("signup.rewardLock");
                this._statusImg.x = 5;
                this._statusImg.y = 30;
                addChild(this._statusImg);
            }
            else if (this._statusImg && this._statusImg.parent)
            {
                this._statusImg.parent.removeChild(this._statusImg);
            }
            return;
        }// end function

    }
}
