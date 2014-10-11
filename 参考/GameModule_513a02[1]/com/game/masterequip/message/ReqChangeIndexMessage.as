package com.game.masterequip.message
{
    import net.*;

    public class ReqChangeIndexMessage extends Message
    {
        private var _type:int;
        private var _index:int;
        private var _targetType:int;
        private var _targetIndex:int;

        public function ReqChangeIndexMessage()
        {
            return;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set index(param1:int) : void
        {
            this._index = param1;
            return;
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        public function set targetType(param1:int) : void
        {
            this._targetType = param1;
            return;
        }// end function

        public function get targetType() : int
        {
            return this._targetType;
        }// end function

        public function set targetIndex(param1:int) : void
        {
            this._targetIndex = param1;
            return;
        }// end function

        public function get targetIndex() : int
        {
            return this._targetIndex;
        }// end function

        override public function getId() : int
        {
            return 600222;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._type);
            writeInt(this._index);
            writeInt(this._targetType);
            writeInt(this._targetIndex);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readInt();
            this._index = readInt();
            this._targetType = readInt();
            this._targetIndex = readInt();
            return true;
        }// end function

    }
}
