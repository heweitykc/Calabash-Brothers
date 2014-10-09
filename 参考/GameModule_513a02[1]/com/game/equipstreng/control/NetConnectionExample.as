package com.game.equipstreng.control
{
    import com.game.equipstreng.events.*;
    import com.game.equipstreng.view.*;
    import flash.display.*;
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;

    public class NetConnectionExample extends Sprite
    {
        private var videoURL:String;
        private var connection:NetConnection;
        private var stream:NetStream;
        private var play_time:Number;
        private var video_width:uint = 410;
        private var video_length:uint = 402;
        private var _bufferTime:uint = 2;
        private var _type:int;

        public function NetConnectionExample()
        {
            return;
        }// end function

        private function AsyncErrorHandler(event:AsyncErrorEvent) : void
        {
            return;
        }// end function

        private function netStatusHandler(event:NetStatusEvent) : void
        {
            switch(event.info.code)
            {
                case "NetStream.Buffer.Full":
                {
                    break;
                }
                case "NetStream.Buffer.Empty":
                {
                    break;
                }
                case "NetStream.Seek.Notify":
                {
                    break;
                }
                case "NetConnection.Connect.Success":
                {
                    this.connectStream();
                    break;
                }
                case "NetStream.Play.StreamNotFound":
                {
                    break;
                }
                case "NetStream.Play.Stop":
                {
                    if (this._type == VideoContainer.TYPE_STRENG)
                    {
                        MyDispatcher.myEvent.dispatchEvent(new VideoEvent(VideoEvent.VIDEO_STRENG_COMPELETE));
                        this.parent.visible = false;
                    }
                    else
                    {
                        MyDispatcher.myEvent.dispatchEvent(new VideoEvent(VideoEvent.VIDEO_FIRE_COMPELETE));
                        this.parent.visible = false;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function securityErrorHandler(event:SecurityErrorEvent) : void
        {
            return;
        }// end function

        private function connectStream() : void
        {
            var _loc_1:* = null;
            if (!this.stream)
            {
                this.stream = new NetStream(this.connection);
                this.stream.addEventListener(NetStatusEvent.NET_STATUS, this.netStatusHandler);
                this.stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.AsyncErrorHandler);
                this.stream.client = new CustomClient();
                this.stream.bufferTime = this._bufferTime;
                _loc_1 = new Video(this.video_width, this.video_length);
                _loc_1.attachNetStream(this.stream);
                this.stream.play(this.videoURL);
                addChild(_loc_1);
            }
            return;
        }// end function

        public function closeStream() : void
        {
            if (this.connection)
            {
                this.connection.removeEventListener(NetStatusEvent.NET_STATUS, this.netStatusHandler);
                this.connection.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityErrorHandler);
                this.connection.close();
                this.connection = null;
            }
            if (this.stream)
            {
                this.stream.removeEventListener(NetStatusEvent.NET_STATUS, this.netStatusHandler);
                this.stream.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, this.AsyncErrorHandler);
                this.stream.close();
                this.stream = null;
            }
            return;
        }// end function

        public function loadVideo(param1:String, param2:int) : void
        {
            this.videoURL = param1;
            this._type = param2;
            if (!this.connection)
            {
                this.connection = new NetConnection();
                this.connection.addEventListener(NetStatusEvent.NET_STATUS, this.netStatusHandler);
                this.connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityErrorHandler);
                this.connection.connect(null);
            }
            return;
        }// end function

        public function play(param1:String, param2:int) : void
        {
            if (this.stream)
            {
                this.stream.seek(0);
            }
            else
            {
                this.loadVideo(param1, param2);
            }
            return;
        }// end function

        public function stop() : void
        {
            if (this.stream)
            {
                this.stream.pause();
            }
            return;
        }// end function

    }
}

import com.game.equipstreng.events.*;

import com.game.equipstreng.view.*;

import flash.display.*;

import flash.events.*;

import flash.media.*;

import flash.net.*;

class CustomClient extends Object
{

    function CustomClient()
    {
        return;
    }// end function

    public function onMetaData(param1:Object) : void
    {
        VideoEvent.VIDEO_TOTALTIME = param1.duration;
        return;
    }// end function

    public function onXMPData(param1:Object) : void
    {
        return;
    }// end function

    public function onPlayStatus(param1:Object) : void
    {
        return;
    }// end function

}

