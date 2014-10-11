package com.game.skill.message
{
    import com.game.structs.*;
    import com.game.utils.*;
    import net.*;

    public class ResFlashMoveMessage extends Message
    {
        private var _roleId:long;
        private var _skillModel:int;
        private var _position:Position;

        public function ResFlashMoveMessage()
        {
            return;
        }// end function

        public function set roleId(param1:long) : void
        {
            this._roleId = param1;
            return;
        }// end function

        public function get roleId() : long
        {
            return this._roleId;
        }// end function

        public function set skillModel(param1:int) : void
        {
            this._skillModel = param1;
            return;
        }// end function

        public function get skillModel() : int
        {
            return this._skillModel;
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

        override public function getId() : int
        {
            return 601100;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._roleId);
            writeInt(this._skillModel);
            writeBean(this._position);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._roleId = readLong();
            this._skillModel = readInt();
            this._position = readBean(Position) as Position;
            return true;
        }// end function

    }
}
