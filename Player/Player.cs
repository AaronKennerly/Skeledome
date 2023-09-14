using Godot;
using System;

public partial class Player : CharacterBody2D
{
	[Export]
	public PlayerControls controls = new PlayerControls();
	
	public const float Speed = 300.0f;
	public const float JumpVelocity = -600.0f;
	public const float Acceleration = 10.0f; 
	public const float Decceleration = 20.0f;

	public const float JumpBufferTime = 0.1f;
	public const float CoyoteTime = 0.2f;
	public float CoyoteTimer;
	public float JumpBufferTimer = -10;
	public bool JumpBool = false;

	public Timer respawnTimer;
	public Vector2 Force;
	public float Mass = 60.0f;
	public int JumpCount = 0;
	public Vector2 velocity;

	// Get the gravity from the project settings to be synced with RigidBody nodes.
	public float gravity = ProjectSettings.GetSetting("physics/2d/default_gravity").AsSingle();

	public override void _Ready()
	{
		respawnTimer = GetNode<Timer>("RespawnTimer");
		respawnTimer.Timeout += OnTimerTimeout;
	}

	public override void _PhysicsProcess(double delta)
	{
		velocity = Velocity;

		if (JumpBufferTimer > 0f) {
            JumpBufferTimer -= (float)delta;
        }

		// handle timer
        if(IsOnFloor()) {
            CoyoteTimer = CoyoteTime;
            JumpCount = 0;
        } else {
            CoyoteTimer -= (float)delta;
        }

		// Add the gravity.
		if (!IsOnFloor())
			if (velocity.Y < 0) velocity.Y += gravity * (float)delta;
			else velocity.Y += gravity * 2 * (float)delta; 

		if (Input.IsActionJustPressed(controls.jump)) {
			JumpBufferTimer = JumpBufferTime;
		}

		// Handle Jump.
		if (Input.IsActionJustPressed(controls.jump) && (CoyoteTimer > 0f || JumpCount < 2)) {
			if (CoyoteTimer < 0f) JumpCount++;
			Jump();
		}
		
		if (JumpBufferTimer >= 0f && IsOnFloor()) {
			JumpCount = 0;
		 	Jump();
		 }
		 
		 // When jump button is released (Janky solution. Reassess)
		if(!Input.IsActionPressed(controls.jump) && JumpBool == true) {
			velocity.Y = velocity.Y + 400.0f;
			CoyoteTimer = 0f;
			JumpBool = false;
		}

		// Get the input direction and handle the movement/deceleration.
		// As good practice, you should replace UI actions with custom gameplay actions.
		
		// calculating Base Movement
		if(Input.IsActionPressed(controls.moveLeft)) {
				if (velocity.X > 0) velocity.X *= 0.75f; //If changing direction, happens slightly faster, feeling better
				velocity.X = Math.Max(velocity.X - Acceleration, -Speed);
		} else if(Input.IsActionPressed(controls.moveRight)) {
				if (velocity.X < 0) velocity.X *= 0.75f;
				velocity.X = Math.Min(velocity.X + Acceleration, Speed);
		} else {
			if (velocity.X < 0) velocity.X = Math.Min(velocity.X + Decceleration, 0);
			else velocity.X = Math.Max(velocity.X - Decceleration, 0);
		}

		Velocity = velocity;
		MoveAndSlide();
		UpdateForce(velocity);
	}
	
	public void UpdateForce(Vector2 velocity) {
		Force = velocity * Mass;
	}

	public void Jump() {
		JumpCount++;
		velocity.Y = JumpVelocity;
		JumpBool = true;
	}

	// this functionis for when the player falls off the map
	public void Die() {
		GameManager.respawnPlayer(this);
	}

	public void OnTimerTimeout() {
		if (Position.Y >= 750 | Position.X <= -200 | Position.X >= 1350) {
			Die();
		}
	}
}
