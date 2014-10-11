package com.game.awardGuide.control
{
    import com.game.backpack.events.*;
    import com.game.backpack.model.*;
    import com.model.vo.*;

    public class BaseAwardGuideControl extends Object
    {
        protected var guideList:Array;

        public function BaseAwardGuideControl()
        {
            this.guideList = [];
            BackpackObj.getInstance().addEventListener(BackpackEvent.BOX_REMOVE, this.removeItem);
            return;
        }// end function

        public function addGuide(param1:Object) : void
        {
            if (this.checkNeedGuide(param1))
            {
                this.addToList(param1);
            }
            return;
        }// end function

        public function removeGuide(param1:Object) : void
        {
            return;
        }// end function

        protected function showGuide(param1:Object) : void
        {
            return;
        }// end function

        protected function addToList(param1:Object) : void
        {
            if (this.checkGuide(param1))
            {
                this.showGuide(param1);
            }
            this.guideList.push(param1);
            return;
        }// end function

        protected function checkNeedGuide(param1:Object) : Boolean
        {
            return true;
        }// end function

        protected function checkGuide(param1:Object) : Boolean
        {
            return true;
        }// end function

        protected function removeItem(event:BackpackEvent) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = event.data as PropInfo;
            var _loc_3:* = 0;
            while (_loc_3 < this.guideList.length)
            {
                
                _loc_4 = this.guideList[_loc_3] as PropInfo;
                if (_loc_4 && _loc_4.itemId.equal(_loc_2.itemId))
                {
                    this.guideList.splice(_loc_3, 1);
                    continue;
                }
                _loc_3++;
            }
            return;
        }// end function

    }
}
