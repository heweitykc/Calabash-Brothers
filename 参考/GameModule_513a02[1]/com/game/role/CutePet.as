package com.game.role
{
    import com.events.*;
    import com.f1.*;
    import com.model.*;
    import com.model.vo.*;
    import com.util.*;
    import flash.events.*;
    import interfaces.role.*;

    public class CutePet extends SimpleRole implements ICutePet
    {

        public function CutePet()
        {
            var _loc_1:* = false;
            this.mouseChildren = false;
            this.mouseEnabled = _loc_1;
            return;
        }// end function

        override public function enterFrame(event:Event = null) : void
        {
            super.enterFrame(event);
            return;
        }// end function

        public function moveToParent(param1:Array) : void
        {
            pathByAStarArray(param1);
            return;
        }// end function

        public function flyToParent() : void
        {
            return;
        }// end function

        override public function set info(param1:RoleInfo) : void
        {
            super.info = param1;
            if (param1)
            {
                FrameworkGlobal.addMsgListen(GameEvent.SHOW_OR_HIDE_PLAYERS, this.showOrHidePlayers);
            }
            this.showOrHidePlayers();
            return;
        }// end function

        private function showOrHidePlayers(event:GameEvent = null) : void
        {
            var _loc_2:* = UICfg.hideOtherPlayer;
            if (_loc_2 && !this.isUserPet())
            {
                visible = false;
            }
            else
            {
                visible = true;
            }
            return;
        }// end function

        private function isUserPet() : Boolean
        {
            if (info && UserObj.getInstance().playerInfo)
            {
                return CutePetInfo(info).parentId.equal(UserObj.getInstance().playerInfo.personId);
            }
            return false;
        }// end function

    }
}
