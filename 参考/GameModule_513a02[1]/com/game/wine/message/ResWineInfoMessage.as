package com.game.wine.message
{
    import com.game.wine.bean.*;
    import net.*;

    public class ResWineInfoMessage extends Message
    {
        private var _config:WineConfig;
        private var _update:WineUpdate;

        public function ResWineInfoMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._config);
            writeBean(this._update);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._config = readBean(WineConfig) as WineConfig;
            this._update = readBean(WineUpdate) as WineUpdate;
            return true;
        }// end function

        override public function getId() : int
        {
            return 159101;
        }// end function

        public function get config() : WineConfig
        {
            return this._config;
        }// end function

        public function set config(param1:WineConfig) : void
        {
            this._config = param1;
            return;
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
