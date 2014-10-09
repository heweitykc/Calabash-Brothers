package com.game.casting.message
{
    import com.game.casting.bean.*;
    import net.*;

    public class ResCastingOpenToClientMessage extends Message
    {
        private var _technologyPoint:int;
        private var _castingBoxInfo:CastingBoxInfo;

        public function ResCastingOpenToClientMessage()
        {
            return;
        }// end function

        public function set technologyPoint(param1:int) : void
        {
            this._technologyPoint = param1;
            return;
        }// end function

        public function get technologyPoint() : int
        {
            return this._technologyPoint;
        }// end function

        public function set castingBoxInfo(param1:CastingBoxInfo) : void
        {
            this._castingBoxInfo = param1;
            return;
        }// end function

        public function get castingBoxInfo() : CastingBoxInfo
        {
            return this._castingBoxInfo;
        }// end function

        override public function getId() : int
        {
            return 529101;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._technologyPoint);
            writeBean(this._castingBoxInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._technologyPoint = readInt();
            this._castingBoxInfo = readBean(CastingBoxInfo) as CastingBoxInfo;
            return true;
        }// end function

    }
}
