package com.game.wine.message
{
    import com.game.wine.bean.*;
    import net.*;

    public class ResWineUpdateMessage extends Message
    {
        private var _update:WineUpdate;

        public function ResWineUpdateMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._update);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._update = readBean(WineUpdate) as WineUpdate;
            return true;
        }// end function

        override public function getId() : int
        {
            return 159102;
        }// end function

        public function get update() : WineUpdate
        {
            return this._update;
        }// end function

        public function set update(param1:WineUpdate) : void
        {
            this._update = param1;
            return;
        }// end function

    }
}
