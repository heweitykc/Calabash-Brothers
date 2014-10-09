package com.f1.manager.sound
{

    public interface ISoundManager
    {

        public function ISoundManager();

        function playBackGroundSound(param1:String, param2:Boolean, param3:Boolean, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number) : Boolean;

        function stopBackGroundSound(param1:Number = -1, param2:Number = 0, param3:Number = 3) : void;

        function play(param1:String, param2:Boolean, param3:Boolean, param4:Function, param5:Number, param6:Number, param7:Number, param8:int) : Boolean;

        function stop(param1:String) : void;

        function stopALL() : void;

        function setSilence(param1:Boolean = true, param2:String = "") : void;

        function setVolume(param1:Number, param2:String) : void;

        function getSoundObjectByKey(param1:String) : SoundObject;

        function addSoundKeyAndUrl(param1:String, param2:String) : void;

    }
}
