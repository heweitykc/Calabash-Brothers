package com.game.friend.message
{
    import net.*;

    public class ResRelationConfigToClientMessage extends Message
    {
        private var _openMapLocation:int;
        private var _showrelation:int;
        private var _showicon:int;
        private var _autoArgeeAddGuild:int;

        public function ResRelationConfigToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._openMapLocation);
            writeByte(this._showrelation);
            writeByte(this._showicon);
            writeByte(this._autoArgeeAddGuild);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._openMapLocation = readByte();
            this._showrelation = readByte();
            this._showicon = readByte();
            this._autoArgeeAddGuild = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 119250;
        }// end function

        public function get openMapLocation() : int
        {
            return this._openMapLocation;
        }// end function

        public function set openMapLocation(param1:int) : void
        {
            this._openMapLocation = param1;
            return;
        }// end function

        public function get showrelation() : int
        {
            return this._showrelation;
        }// end function

        public function set showrelation(param1:int) : void
        {
            this._showrelation = param1;
            return;
        }// end function

        public function get showicon() : int
        {
            return this._showicon;
        }// end function

        public function set showicon(param1:int) : void
        {
            this._showicon = param1;
            return;
        }// end function

        public function get autoArgeeAddGuild() : int
        {
            return this._autoArgeeAddGuild;
        }// end function

        public function set autoArgeeAddGuild(param1:int) : void
        {
            this._autoArgeeAddGuild = param1;
            return;
        }// end function

    }
}
