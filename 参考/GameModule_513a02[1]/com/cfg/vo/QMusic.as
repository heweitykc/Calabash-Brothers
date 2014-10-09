package com.cfg.vo
{

    public class QMusic extends Object
    {
        public var q_id:String;
        public var q_music:String;
        public var q_type:int;
        public var q_play_type:int;
        public var q_frequency:int;
        public var q_kind:int;
        public var q_key:int;
        public var q_level:int;

        public function QMusic()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            this.q_id = param1.q_id;
            this.q_music = param1.q_music;
            this.q_type = param1.q_type;
            this.q_play_type = param1.q_play_type;
            this.q_frequency = param1.q_frequency;
            this.q_kind = param1.q_kind;
            this.q_key = param1.q_key;
            this.q_level = param1.q_level;
            return;
        }// end function

    }
}
