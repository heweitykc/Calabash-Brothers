package com.game.task.message
{
    import com.game.utils.*;
    import net.*;

    public class ResConquerTaskAnnexMessage extends Message
    {
        private var _vanishTaskId:long;

        public function ResConquerTaskAnnexMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._vanishTaskId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._vanishTaskId = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 120107;
        }// end function

        public function get vanishTaskId() : long
        {
            return this._vanishTaskId;
        }// end function

        public function set vanishTaskId(param1:long) : void
        {
            this._vanishTaskId = param1;
            return;
        }// end function

    }
}
