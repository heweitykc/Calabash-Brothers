package com.f1.manager.sound
{
    import com.f1.utils.*;
    import com.greensock.*;
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;

    public class SoundObject extends Object
    {
        private var key:String;
        private var url:String;
        private var _loop:Boolean = false;
        private var isLoading:Boolean = true;
        public var isPlay:Boolean = false;
        public var isDuring:Boolean = false;
        public var separate:Number = 0;
        private var position:Number = 0;
        private var sound:Sound;
        private var soundChannel:SoundChannel;
        private var soundTransform:SoundTransform;
        private var _playCompleteHandler:Function;
        private var _playDuringTime:Number;
        private var _playEndVolume:Number;
        private var _playStartVolume:Number;

        public function SoundObject(param1:String, param2:String)
        {
            this.key = param1;
            this.url = param2;
            this.sound = new Sound();
            this.sound.load(new URLRequest(this.url), new SoundLoaderContext(3000, false));
            this.sound.addEventListener(Event.COMPLETE, this.completeHandler);
            this.sound.addEventListener(IOErrorEvent.IO_ERROR, this.errorHandler);
            return;
        }// end function

        public function get loop() : Boolean
        {
            return this._loop;
        }// end function

        public function get playCompleteHandler() : Function
        {
            return this._playCompleteHandler;
        }// end function

        private function errorHandler(event:IOErrorEvent) : void
        {
            Log.log("SoundObject.errorHandler", this.url, "add by zhengchen", new Date().toString());
            return;
        }// end function

        private function completeHandler(event:Event) : void
        {
            this.isLoading = false;
            return;
        }// end function

        public function stop(param1:Number = -1, param2:Number = 0, param3:Number = 0, param4:Number = 0) : void
        {
            if (this.isPlay && this.soundChannel != null)
            {
                if (this.loop && this.separate > 0)
                {
                    TweenLite.killTweensOf(this.play);
                }
                if (this.isDuring)
                {
                    TweenLite.killTweensOf(this.soundTransform, false);
                    this.isDuring = false;
                }
                if (param3 == 0)
                {
                    this.position = this.soundChannel.position;
                    this.soundChannel.stop();
                    this.isPlay = false;
                }
                else if (!this.isDuring)
                {
                    this.isDuring = true;
                    this.soundTransform = this.soundChannel.soundTransform;
                    this.soundTransform.volume = param1 < 0 ? (this.soundTransform.volume) : (param1);
                    this.soundChannel.soundTransform = this.soundTransform;
                    TweenLite.to(this.soundTransform, param3, {delay:param4, volume:param2, onUpdate:this.onUpdate, onComplete:this.fadeOutComplete});
                }
            }
            return;
        }// end function

        private function onUpdate() : void
        {
            this.soundChannel.soundTransform = this.soundTransform;
            return;
        }// end function

        private function fadeInComplete() : void
        {
            this.isDuring = false;
            return;
        }// end function

        private function fadeOutComplete() : void
        {
            this.position = this.soundChannel.position;
            this.soundChannel.stop();
            this.isPlay = false;
            this.isDuring = false;
            return;
        }// end function

        public function setVolume(param1:Number) : void
        {
            var _loc_2:* = null;
            if (this.soundChannel != null)
            {
                if (this.isDuring)
                {
                    TweenLite.killTweensOf(this.soundTransform, false);
                    this.isDuring = false;
                }
                _loc_2 = this.soundChannel.soundTransform;
                _loc_2.volume = param1;
                this.soundChannel.soundTransform = _loc_2;
            }
            return;
        }// end function

        public function play(param1:Boolean = false, param2:Boolean = false, param3:Boolean = false, param4:Function = null, param5:Number = -1, param6:Number = 1, param7:Number = 0, param8:Number = 0, param9:Number = 0) : void
        {
            var _loc_10:* = null;
            this._playDuringTime = param7;
            this._playEndVolume = param6;
            this._playStartVolume = param5;
            this._loop = param2;
            this._playCompleteHandler = param4;
            if (this.isDuring)
            {
                TweenLite.killTweensOf(this.soundTransform, false);
                this.isDuring = false;
            }
            if (!param1 && this.isLoading)
            {
                return;
            }
            if (this.isPlay && param3)
            {
                if (this.soundChannel != null)
                {
                    this.soundChannel.stop();
                    this.soundChannel = null;
                    this.isPlay = false;
                }
            }
            if (!this.isPlay)
            {
                if (param9 <= 0)
                {
                    this.soundChannel = this.sound.play(0, this.loop ? (10000) : (0));
                }
                else
                {
                    this.sound.play();
                }
                this.isPlay = true;
            }
            if (this.soundChannel != null)
            {
                if (param7 > 0)
                {
                    this.isDuring = true;
                    this.soundTransform = this.soundChannel.soundTransform;
                    this.soundTransform.volume = param5 < 0 ? (this.soundTransform.volume) : (param5);
                    this.soundChannel.soundTransform = this.soundTransform;
                    if (param7 != 0)
                    {
                        TweenLite.to(this.soundTransform, param7, {delay:param8, volume:param6, onUpdate:this.onUpdate, onComplete:this.fadeInComplete});
                    }
                }
                else
                {
                    _loc_10 = this.soundChannel.soundTransform;
                    _loc_10.volume = param6;
                    this.soundChannel.soundTransform = _loc_10;
                }
                this.soundChannel.addEventListener(Event.SOUND_COMPLETE, this.soundCompleteHandler);
            }
            return;
        }// end function

        private function soundCompleteHandler(event:Event) : void
        {
            if (this._playCompleteHandler != null)
            {
                this._playCompleteHandler(event);
            }
            if (this.loop)
            {
                if (this.separate > 0)
                {
                    TweenLite.delayedCall(this.separate, this.play, [false, this.loop, false, this._playCompleteHandler, this._playStartVolume, this._playEndVolume, this._playDuringTime, 0, this.separate]);
                }
            }
            this.isPlay = false;
            this.isDuring = false;
            this.position = 0;
            this._playCompleteHandler = null;
            this.soundChannel.removeEventListener(Event.SOUND_COMPLETE, this.soundCompleteHandler);
            return;
        }// end function

        public function finalize() : void
        {
            return;
        }// end function

    }
}
