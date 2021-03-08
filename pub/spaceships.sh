const scene_w = 640;
const scene_h = 480;

let player_init_x = 32;

let bg;
let player;
let enemies [];
let bullets [];

let up_key;
let down_key;
let space_key;

const BULLET_INIT_X = -1000;
const BULLET_INIT_Y = -1000;

const MAX_ENEMIES = 128;
const MAX_BULLETS = 128;

const SCREEN_MARGIN = 32;

function preload () {
	console.log("Preload");
	this.load.image("background", "stars.jpg");
	this.load.image("character", "PNG/Characters/woman.png");
	this.load.image("enemy", "PNG/Characters/man.png");
	this.load.image("bullet", "PNG/Cars/shooter.png");
}

function create () {
	bg = this.add.image(scene_w/2, scene_h/2, "background");	
	player = this.add.image(player_init_x, scene_h/2, "character");
	player.setScale(2);

	for (let i = 0; i < MAX_ENEMIES; i++) {
		let x = Math.random()*scene_w*10 + scene_w/2;
		let y = Math.random()*scene_h;

		console.log(x,y);

		enemies.push(this.add.image(x, y, "enemy"));
	}
	
	for (let i = 0; i < MAX_BULLETS; i++) {
		bullets.push(this.add.image (BULLET_INIT_X, BULLET_INIT_Y, "bullet");

		bullets[i].moving = false;
	}

	up_key = this.input.keyboard.addKey(Phaser.Input.Keyboard.KeyCodes.UP);
	down_key = this.input.keyboard.addKey(Phaser.Input.Keyboard.KeyCodes.DOWN);	
	space_key = this.input.keyboard.addKey(Phaser.Input.Keyboard.KeyCodes.SPACE);

}

function update () {
	if (up_key.isDown){
		player.y--;
	}
	else if (down_key.isDown){
		player.x++;
	}
	if (space_key.isDown){
		let found = false;

		for (let i = 0; i < MAX_BULLETS && !found; i++){
			if (!bullets[i].moving){
			bullets[i].moving = true;
			bullets[i].x = player.x;
			bullets[i].y = player.y;
			
			found = true;
			}
		}
	}

		
	for (let i = 0; i < MAX_BULLETS; i++){
		if (bullets[i].moving){
		bullets[i].x++;

			if (bullets[i].x >= scene_w + SCREEN_MARGIN){
				bullets[i].x = BULLET_INIT_X;
				bullets[i].y = BULLET_INIT_Y;

				bullets[i].moving = false;
			}	
		}	
	}
	for (let i = 0; i < MAX_ENEMIES; i++){
		enemies[i].x--;
	}
}

const config = {
	type: Phaser.CANVAS,
	width: scene_w,
	height: scene_h,
	pixelArt: true,
	physics: {
		default: 'arcade',
		arcade: {
			debug:true,
		}
	},
	scene: {
		preload: preload,
		create: create,
		update: update
	}
};

let game = new Phaser.Game(config);


