sim=require'sim'

function sysCall_init()

    -- Sensors
    proximitySensor=sim.getObject('/proximitySensor')
    visionSensor=sim.getObject('/visionSensor')

    -- Wheel motors
    FL=sim.getObject('/FLwheel_motor')
    FR=sim.getObject('/FRwheel_motor')
    RL=sim.getObject('/RLwheel_motor')
    RR=sim.getObject('/RRwheel_motor')

    -- Internal representation
    pathStatus='clear'

    -- Movement state
    state='forward'
    timer=0

    print('Vision sensor initialized for environmental awareness')

end


function sysCall_actuation()

    result,distance=sim.readProximitySensor(proximitySensor)

    -- Obstacle detected while moving forward
    if result > 0 and state=='forward' then
        pathStatus='blocked'
        state='backup'
        timer=sim.getSimulationTime()+1.0
    end

    if state=='backup' then

        -- Back away from obstacle
        sim.setJointTargetVelocity(FL,-8)
        sim.setJointTargetVelocity(FR,8)
        sim.setJointTargetVelocity(RL,-8)
        sim.setJointTargetVelocity(RR,8)

        if sim.getSimulationTime() > timer then
            state='slide'
            timer=sim.getSimulationTime()+2.0
        end

    elseif state=='slide' then

        -- Slide sideways around obstacle
        sim.setJointTargetVelocity(FL,-8)
        sim.setJointTargetVelocity(FR,-8)
        sim.setJointTargetVelocity(RL,8)
        sim.setJointTargetVelocity(RR,8)

        if sim.getSimulationTime() > timer then
            state='forward'
            pathStatus='clear'
        end

    else

        -- Move forward
        sim.setJointTargetVelocity(FL,8)
        sim.setJointTargetVelocity(FR,-8)
        sim.setJointTargetVelocity(RL,8)
        sim.setJointTargetVelocity(RR,-8)

    end

end


function sysCall_cleanup()

    -- Stop robot when simulation ends
    sim.setJointTargetVelocity(FL,0)
    sim.setJointTargetVelocity(FR,0)
    sim.setJointTargetVelocity(RL,0)
    sim.setJointTargetVelocity(RR,0)

end