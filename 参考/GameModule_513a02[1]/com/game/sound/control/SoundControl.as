package com.game.sound.control
{
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.manager.sound.*;
    import com.f1.manager.timer.*;
    import com.game.player.control.*;
    import com.greensock.*;
    import com.staticdata.*;

    public class SoundControl extends Object
    {
        private const MP3:String = ".mp3";
        private const SOUND:String = "art/res/sound/";
        private const BGM:String;
        private const OTHTER:String;
        private const ITEM:String;
        private const MONSTER:String;
        private const NPC:String;
        private const SKILL:String;
        private var _volume:Number = 1;
        private var _bgKey:String;
        private var hasItemCfg:Boolean = false;
        private const NPC_PLAY_NUM:int = 2;
        public var currentPlayType:int = 1;
        private var _delay:Array;
        private static var _instance:SoundControl;

        public function SoundControl()
        {
            this.BGM = this.SOUND + "bgm/";
            this.OTHTER = this.SOUND + "other/";
            this.ITEM = this.SOUND + "item/";
            this.MONSTER = this.SOUND + "monster/";
            this.NPC = this.SOUND + "npc/";
            this.SKILL = this.SOUND + "skill/";
            this._delay = new Array();
            SoundManager.setSilence(false, SoundManager.SILENCE_ALL);
            this.initCfg();
            Ticker.registerTimer(1, this.update);
            return;
        }// end function

        private function update() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_4:* = null;
            var _loc_3:* = 0;
            while (_loc_3 < this._delay.length)
            {
                
                _loc_2 = this._delay[_loc_3];
                if (_loc_2 && _loc_2.key)
                {
                    _loc_4 = SoundManager.getSoundObjectByKey(_loc_2.key);
                    if (_loc_4 && !_loc_4.isPlay)
                    {
                        var _loc_5:* = _loc_2;
                        var _loc_6:* = _loc_2.delay - 1;
                        _loc_5.delay = _loc_6;
                        if (_loc_2.delay <= 0)
                        {
                            this._delay.splice(_loc_3, 1);
                        }
                        else
                        {
                            _loc_3++;
                        }
                    }
                    else
                    {
                        _loc_3++;
                    }
                    continue;
                }
                this._delay.splice(_loc_3, 1);
            }
            return;
        }// end function

        private function canPlay(param1:String) : Boolean
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._delay)
            {
                
                if (_loc_2.key == param1)
                {
                    return false;
                }
            }
            return true;
        }// end function

        public function playbtnMusic() : void
        {
            return;
        }// end function

        public function playBGM(param1:String = null) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = QMusicCfgObj.getInstance().getMusicByKey("1");
            TweenLite.killTweensOf(this.playBgSound);
            if (param1 && param1 != "")
            {
                SoundManager.stopBackGroundSound();
                param1 = this.BGM + param1.split(";")[0];
                _loc_3 = /\//g;
                this._bgKey = param1.replace(_loc_3, "_");
                if (this.currentPlayType == SoundType.PLAYNO || this.currentPlayType == SoundType.PLAYKEY && !this.isKeySound(_loc_2.q_key))
                {
                    return;
                }
            }
            else
            {
                return;
            }
            SoundManager.stopAll();
            if (!SoundManager.playBackGroundSound(this._bgKey))
            {
                SoundManager.addKeyValueMap(this._bgKey, param1 + this.MP3);
                TweenLite.delayedCall(30, this.playBgSound, [this._bgKey, _loc_2.q_level]);
            }
            return;
        }// end function

        private function playBgSound(param1:String, param2:int) : void
        {
            SoundManager.playBackGroundSound(this._bgKey, true, true, -1, 0, 3, 0, this.getSoundVolume(param2));
            return;
        }// end function

        private function initCfg() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = QMusicCfgObj.getInstance().getMusicCfg();
            for each (_loc_2 in _loc_1)
            {
                
                if (!_loc_2.q_music || _loc_2.q_music == "")
                {
                    continue;
                }
                SoundManager.addKeyValueMap(_loc_2.q_id, this.OTHTER + _loc_2.q_music + this.MP3);
            }
            return;
        }// end function

        public function playSound(param1:String) : void
        {
            var _loc_2:* = QMusicCfgObj.getInstance().getMusicByKey(param1);
            if (this.currentPlayType == SoundType.PLAYNO || this.currentPlayType == SoundType.PLAYKEY && !this.isKeySound(_loc_2.q_key))
            {
                return;
            }
            SoundManager.play(param1, false, true, null, 0, this.getSoundVolume(_loc_2.q_level), 0.5);
            return;
        }// end function

        public function playItemSound(param1:String, param2:uint) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_3:* = QMusicCfgObj.getInstance().getMusicByKey(param1);
            var _loc_4:* = ItemCfgObj.getInstance().getCfgBy(param2);
            if (!ItemCfgObj.getInstance().getCfgBy(param2) || this.currentPlayType == SoundType.PLAYNO || this.currentPlayType == SoundType.PLAYKEY && !(this.isKeySound(_loc_3.q_key) || _loc_3.q_key == 3 && _loc_4.q_ikey == 1))
            {
                return;
            }
            if (!_loc_4)
            {
                return;
            }
            if (param1 == SoundFlag.USE_ITEM)
            {
                if (_loc_4.q_use_music == null || _loc_4.q_use_music == "")
                {
                    return;
                }
                _loc_5 = "item_" + _loc_4.q_use_music;
                _loc_6 = this.ITEM + _loc_4.q_use_music + this.MP3;
            }
            else if (param1 == SoundFlag.DROP_ITEM)
            {
                if (_loc_4.q_drop_music == null || _loc_4.q_drop_music == "")
                {
                    return;
                }
                _loc_5 = "item_" + _loc_4.q_drop_music;
                _loc_6 = this.ITEM + _loc_4.q_drop_music + this.MP3;
            }
            else if (param1 == SoundFlag.UNWEAREQUIP)
            {
                if (_loc_4.q_unuse_music == null || _loc_4.q_unuse_music == "")
                {
                    return;
                }
                _loc_5 = "item_" + _loc_4.q_unuse_music;
                _loc_6 = this.ITEM + _loc_4.q_unuse_music + this.MP3;
            }
            SoundManager.addKeyValueMap(_loc_5, _loc_6);
            SoundManager.play(_loc_5, false, true, null, 0, this.getSoundVolume(_loc_3.q_level));
            return;
        }// end function

        public function playMonseterSound(param1:String, param2:uint, param3:int = 0) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_4:* = QMusicCfgObj.getInstance().getMusicByKey(param1);
            if (this.currentPlayType == SoundType.PLAYNO || this.currentPlayType == SoundType.PLAYKEY && !this.isKeySound(_loc_4.q_key))
            {
                return;
            }
            var _loc_5:* = MonsterCfgObj.getInstance().getMonsterObjCfg(param2);
            if (!MonsterCfgObj.getInstance().getMonsterObjCfg(param2))
            {
                return;
            }
            if (param1 == SoundFlag.MONSTER_SOUND)
            {
                _loc_8 = _loc_4.q_frequency;
                if (!_loc_5.q_sound || _loc_5.q_sound == "")
                {
                    return;
                }
                _loc_6 = "monster_" + (_loc_5.q_sound as String).split(";")[0];
                if (!this.canPlay(_loc_6))
                {
                    return;
                }
                _loc_7 = this.MONSTER + (_loc_5.q_sound as String).split(";")[0] + this.MP3;
                this._delay.push({key:_loc_6, delay:_loc_8});
            }
            else if (param1 == SoundFlag.MONSTER_DIE)
            {
                _loc_6 = "monster_" + (_loc_5.q_die_sound as String).split(";")[0];
                _loc_7 = this.MONSTER + (_loc_5.q_die_sound as String).split(";")[0] + this.MP3;
            }
            SoundManager.addKeyValueMap(_loc_6, _loc_7);
            SoundManager.play(_loc_6, false, true, null, 0, this.getSoundVolume(_loc_4.q_level));
            return;
        }// end function

        public function setVolume(param1:Number) : void
        {
            SoundManager.volume = param1;
            SoundManager.setVolume(param1, this._bgKey);
            this._volume = param1;
            return;
        }// end function

        public function playNpcSound(param1:int, param2:String) : void
        {
            var _loc_3:* = QMusicCfgObj.getInstance().getMusicByKey(param2);
            if (this.currentPlayType == SoundType.PLAYNO || this.currentPlayType == SoundType.PLAYKEY && !this.isKeySound(_loc_3.q_key))
            {
                return;
            }
            var _loc_4:* = NpcCfgObj.getInstance().getNpcByID(param1.toString());
            if (!NpcCfgObj.getInstance().getNpcByID(param1.toString()))
            {
                return;
            }
            var _loc_5:* = _loc_4.q_sound;
            if (_loc_4.q_sound == null || _loc_5 == "")
            {
                return;
            }
            _loc_5 = _loc_5.split(";")[0];
            if (_loc_5 == null || _loc_5 == "")
            {
                return;
            }
            var _loc_6:* = this.NPC + _loc_5 + this.MP3;
            _loc_5 = "npc_" + _loc_5;
            SoundManager.addKeyValueMap(_loc_5, _loc_6);
            SoundManager.play(_loc_5, false, false, null, 0, this.getSoundVolume(_loc_3.q_level), 0.2);
            return;
        }// end function

        public function stopNpcSound(param1:int, param2:String) : void
        {
            var _loc_3:* = NpcCfgObj.getInstance().getNpcByID(param1.toString());
            if (!_loc_3)
            {
                return;
            }
            var _loc_4:* = _loc_3.q_sound;
            if (_loc_3.q_sound == null || _loc_4 == "")
            {
                return;
            }
            _loc_4 = "npc_" + _loc_4;
            SoundManager.stop(_loc_4);
            return;
        }// end function

        public function playSkillSound(param1:String, param2:String) : void
        {
            var _loc_3:* = QMusicCfgObj.getInstance().getMusicByKey(param2);
            if (this.currentPlayType == SoundType.PLAYNO || this.currentPlayType == SoundType.PLAYKEY && !this.isKeySound(_loc_3.q_key))
            {
                return;
            }
            var _loc_4:* = param1;
            if (param1 == null || _loc_4 == "")
            {
                return;
            }
            var _loc_5:* = this.SKILL + _loc_4 + this.MP3;
            _loc_4 = "skill_" + _loc_4;
            SoundManager.addKeyValueMap(_loc_4, _loc_5);
            SoundManager.play(_loc_4, false, true, null, 0.1, this.getSoundVolume(_loc_3.q_level), 0.2);
            return;
        }// end function

        public function setting(param1:int) : void
        {
            if (param1 == SoundType.PLAYALL)
            {
                SoundManager.setSilence(false);
                SoundManager.playBackGroundSound(this._bgKey);
                SoundManager.onlyPlayKeySound = false;
            }
            else if (param1 == SoundType.PLAYKEY)
            {
                SoundManager.setSilence(false);
                SoundManager.stopBackGroundSound();
                SoundManager.onlyPlayKeySound = true;
            }
            else if (param1 == SoundType.PLAYNO)
            {
                SoundManager.stopAll();
                SoundManager.setSilence();
                SoundManager.onlyPlayKeySound = false;
            }
            else
            {
                return;
            }
            this.currentPlayType = param1;
            PlayerControl.getInstance().saveConfig(param1, PlayerConfig.SOUND_SETTING);
            return;
        }// end function

        private function isKeySound(param1:int) : Boolean
        {
            return param1 == 1;
        }// end function

        private function getSoundVolume(param1:int) : Number
        {
            return param1 / 10 * this._volume;
        }// end function

        private function initItemMusicCfg() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = ItemCfgObj.getInstance().getCfg();
            for (_loc_3 in _loc_1)
            {
                
                _loc_2 = _loc_1[_loc_3];
                if (_loc_2.q_unuse_music && _loc_2.q_unuse_music != "")
                {
                    SoundManager.addKeyValueMap("item_" + _loc_2.q_id, this.ITEM + _loc_2.q_unuse_music + this.MP3);
                }
                if (_loc_2.q_unuse_music && _loc_2.q_unuse_music != "")
                {
                    SoundManager.addKeyValueMap("item_" + _loc_2.q_id, this.ITEM + _loc_2.q_unuse_music + this.MP3);
                }
            }
            return;
        }// end function

        public static function getInstance() : SoundControl
        {
            if (!_instance)
            {
                _instance = new SoundControl;
            }
            return _instance;
        }// end function

    }
}
