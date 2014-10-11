package com.game.summonpet.message
{
    import com.game.structs.*;
    import com.game.utils.*;
    import net.*;

    public class ResSummonPetStopMessage extends Message
    {
        private var _petId:long;
        private var _position:Position;
        private var _mapModelId:int;

        public function ResSummonPetStopMessage()
        {
            return;
        }// end function

        public function set petId(param1:long) : void
        {
            this._petId = param1;
            return;
        }// end function

        public function get petId() : long
        {
            return this._petId;
        }// end function

        public function set position(param1:Position) : void
        {
            this._position = param1;
            return;
        }// end function

        public function get position() : Position
        {
            return this._position;
        }// end function

        public function get mapModelId() : int
        {
            return this._mapModelId;
        }// end function

        public function set mapModelId(param1:int) : void
        {
            this._mapModelId = param1;
            return;
        }// end function

        override public function getId() : int
        {
            return 501121;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._petId);
            writeBean(this._position);
            writeInt(this._mapModelId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._petId = readLong();
            this._position = readBean(Position) as Position;
            this._mapModelId = readInt();
            return true;
        }// end function

    }
}
