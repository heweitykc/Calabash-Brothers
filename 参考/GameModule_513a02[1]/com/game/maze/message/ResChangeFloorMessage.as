package com.game.maze.message
{
    import net.*;

    public class ResChangeFloorMessage extends Message
    {
        private var _type:int;
        private var _floor:int;
        private var _remain:int;

        public function ResChangeFloorMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._type);
            writeInt(this._floor);
            writeInt(this._remain);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readInt();
            this._floor = readInt();
            this._remain = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 145101;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get floor() : int
        {
            return this._floor;
        }// end function

        public function set floor(param1:int) : void
        {
            this._floor = param1;
            return;
        }// end function

        public function get remain() : int
        {
            return this._remain;
        }// end function

        public function set remain(param1:int) : void
        {
            this._remain = param1;
            return;
        }// end function

    }
}
