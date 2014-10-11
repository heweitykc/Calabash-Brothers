package com.game.casting.message
{
    import com.game.casting.bean.*;
    import net.*;

    public class ResCastingRewardToClientMessage extends Message
    {
        private var _itemInfo:CastingGridInfo;

        public function ResCastingRewardToClientMessage()
        {
            return;
        }// end function

        public function set itemInfo(param1:CastingGridInfo) : void
        {
            this._itemInfo = param1;
            return;
        }// end function

        public function get itemInfo() : CastingGridInfo
        {
            return this._itemInfo;
        }// end function

        override public function getId() : int
        {
            return 529102;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._itemInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._itemInfo = readBean(CastingGridInfo) as CastingGridInfo;
            return true;
        }// end function

    }
}
