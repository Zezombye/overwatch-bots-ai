#!mainFile "../main.opy"

rule "Navigation: Lijiang Tower - Waypoints":
    @Condition (getCurrentMap() == Map.LIJIANG_TOWER or getCurrentMap() == Map.LIJIANG_TOWER_LNY) == true
    @Condition isGameInProgress() == true
    
    if getCurrentObjective() == 0:
        Waypoints = []
        Waypoints.append(vect(48.411, 3.349, -41.642))
        Waypoints.append(vect(37.788, 2.872, -42.043))
        Waypoints.append(vect(29.968, 1.348, -42.119))
        Waypoints.append(vect(60.669, 3.348, -34.315))
        Waypoints.append(vect(25.651, 1.348, -39.936))
        Waypoints.append(vect(18.354, 1.211, -40.729))
        Waypoints.append(vect(18.756, 1.348, -50.839))
        Waypoints.append(vect(27.629, -1.612, -54.271))
        Waypoints.append(vect(15.114, -1.649, -57.362))
        Waypoints.append(vect(11.938, 0.432, -75.489))
        Waypoints.append(vect(15.616, 0.352, -67.293))
        Waypoints.append(vect(5.075, 0.352, -66.238))
        Waypoints.append(vect(-0.113, 0.352, -66.067))
        Waypoints.append(vect(-3.053, 0.352, -61.179))
        Waypoints.append(vect(-1.109, 0.352, -56.23))
        Waypoints.append(vect(5.867, 0.352, -57.027))
        Waypoints.append(vect(6.381, 0.352, -63.703))
        Waypoints.append(vect(1.147, 0.352, -71.036))
        Waypoints.append(vect(7.021, 0.352, -76.019))
        Waypoints.append(vect(6.004, -0.651, -81.268))
        Waypoints.append(vect(-4.808, -0.651, -81.109))
        Waypoints.append(vect(-3.225, 0.352, -75.504))
        Waypoints.append(vect(-11.011, 0.352, -72.941))
        Waypoints.append(vect(-10.091, 0.352, -66.775))
        Waypoints.append(vect(-13.227, -1.651, -55.824))
        Waypoints.append(vect(-26.371, -1.652, -54.017))
        Waypoints.append(vect(-26.371, -1.652, -54.017))
        Waypoints.append(vect(-16.119, 1.211, -40.62))
        Waypoints.append(vect(-24.771, 1.351, -39.692))
        Waypoints.append(vect(-31.221, 1.352, -41.946))
        Waypoints.append(vect(-24.189, 1.348, -42.333))
        Waypoints.append(vect(-44.021, 3.351, -41.647))
        Waypoints.append(vect(-53.333, 3.211, -37.247))
        Waypoints.append(vect(-61.939, 3.349, -32.009))
        Waypoints.append(vect(-50.225, 3.211, -45.753))
        Waypoints.append(vect(-39.953, 7.359, -45.86))
        Waypoints.append(vect(-25.46, 7.352, -40.864))
        Waypoints.append(vect(-22.7, 7.352, -29.12))
        Waypoints.append(vect(-23.425, 7.351, -21.687))
        Waypoints.append(vect(-24.317, 7.351, -13.912))
        Waypoints.append(vect(-18.275, 7.351, -9.026))
        Waypoints.append(vect(-15.444, 7.422, -17.578))
        Waypoints.append(vect(-47.347, 5.348, -13.826))
        Waypoints.append(vect(-47.515, 3.211, -21.899))
        Waypoints.append(vect(-55.34, 3.211, -22.01))
        Waypoints.append(vect(-50.957, 3.349, -28.734))
        Waypoints.append(vect(-38.277, 1.211, -22.145))
        Waypoints.append(vect(-37.597, 1.211, -30.198))
        Waypoints.append(vect(-26.233, 1.351, -36.174))
        Waypoints.append(vect(-25.839, 1.351, -26.858))
        Waypoints.append(vect(-24.813, 1.351, -17.601))
        Waypoints.append(vect(-14.348, 1.351, -19.133))
        Waypoints.append(vect(-17.118, 1.349, -14.801))
        Waypoints.append(vect(-15.879, 1.349, -10.111))
        Waypoints.append(vect(-5.004, 1.358, -12.046))
        Waypoints.append(vect(1.127, 1.351, -14.854))
        Waypoints.append(vect(1.146, 0.211, -25.184))
        Waypoints.append(vect(-10.268, 1.109, -24.859))
        Waypoints.append(vect(-15.777, 1.211, -32.222))
        Waypoints.append(vect(-9.837, 0.893, -34.644))
        Waypoints.append(vect(1.24, 0.211, -35.105))
        Waypoints.append(vect(-4.748, 0.349, -37.375))
        Waypoints.append(vect(-3.549, 0.372, -47.264))
        Waypoints.append(vect(5.445, 0.372, -48.129))
        Waypoints.append(vect(7.002, 0.211, -36.978))
        Waypoints.append(vect(13.634, 1.351, -34.99))
        Waypoints.append(vect(18.367, 1.348, -28.761))
        Waypoints.append(vect(15.075, 1.211, -24.08))
        Waypoints.append(vect(7.698, 0.211, -25.007))
        Waypoints.append(vect(7.855, 1.352, -12.165))
        Waypoints.append(vect(18.376, 1.35, -10.092))
        Waypoints.append(vect(10.127, 1.35, -17.335))
        Waypoints.append(vect(26.172, 1.351, -16.627))
        Waypoints.append(vect(27.791, 1.351, -27.533))
        Waypoints.append(vect(27.616, 1.351, -35.005))
        Waypoints.append(vect(37.337, 1.351, -34.574))
        Waypoints.append(vect(49.744, 2.846, -36.703))
        Waypoints.append(vect(35.787, 1.211, -28.334))
        Waypoints.append(vect(42.332, 1.348, -21.934))
        Waypoints.append(vect(48.638, 3.211, -21.668))
        Waypoints.append(vect(53.433, 3.211, -21.534))
        Waypoints.append(vect(53.868, 3.348, -29.854))
        Waypoints.append(vect(49.756, 5.349, -13.449))
        Waypoints.append(vect(26.979, 7.351, -13.877))
        Waypoints.append(vect(20.541, 7.351, -9.005))
        Waypoints.append(vect(17.113, 7.352, -12.271))
        Waypoints.append(vect(17.657, 7.351, -16.999))
        Waypoints.append(vect(24.805, 7.352, -26.822))
        Waypoints.append(vect(26.222, 7.39, -45.539))
        Waypoints.append(vect(41.587, 7.351, -46.105))
        Waypoints.append(vect(51.971, 3.348, -43.969))
        Waypoints.append(vect(-69.207, 5.83, -30.877))
        Waypoints.append(vect(24.003, 0.594, -54.419))
        Waypoints.append(vect(7.546, -0.072, -30.9))
        Waypoints.append(vect(-8.639, 0.956, -31.186))
        Waypoints.append(vect(-23.099, 0.171, -53.778))
        Waypoints.append(vect(-9.767, 0.609, -65.011))
        Waypoints.append(vect(-5.506, 0.134, -65.477))
        Waypoints.append(vect(-18.384, 0.524, -51.133))
        Waypoints.append(vect(-12.063, -2.44, -58.622))
    if getCurrentObjective() == 1:
        Waypoints = []
        Waypoints.append(vect(11.961, 96.78, 129.132))
        Waypoints.append(vect(71.559, 98.69, 145.591))
        Waypoints.append(vect(78.318, 98.264, 144.688))
        Waypoints.append(vect(60.759, 95.691, 143.992))
        Waypoints.append(vect(58.224, 95.7, 168.501))
        Waypoints.append(vect(47.643, 99.7, 168.07))
        Waypoints.append(vect(-0.077, 95.7, 177.821))
        Waypoints.append(vect(34.274, 99.7, 163.876))
        Waypoints.append(vect(25.799, 99.7, 164.311))
        Waypoints.append(vect(16.31, 95.7, 170.217))
        Waypoints.append(vect(25.971, 95.7, 171.612))
        Waypoints.append(vect(33.313, 95.7, 165.545))
        Waypoints.append(vect(33.746, 99.7, 180.383))
        Waypoints.append(vect(30.038, 95.7, 161.645))
        Waypoints.append(vect(36.41, 96.682, 160.08))
        Waypoints.append(vect(45.632, 96.7, 151.638))
        Waypoints.append(vect(34.737, 96.693, 149.602))
        Waypoints.append(vect(30.716, 95.699, 148.248))
        Waypoints.append(vect(23.736, 95.699, 144.945))
        Waypoints.append(vect(20.346, 97.7, 133.621))
        Waypoints.append(vect(11.423, 96.7, 127.551))
        Waypoints.append(vect(12.649, 96.7, 115.729))
        Waypoints.append(vect(5.94, 97.7, 116.037))
        Waypoints.append(vect(4.21, 97.7, 107.594))
        Waypoints.append(vect(-4.517, 97.7, 107.727))
        Waypoints.append(vect(0.282, 98.615, 116.674))
        Waypoints.append(vect(-6.369, 97.7, 116.191))
        Waypoints.append(vect(-12.184, 96.886, 116.684))
        Waypoints.append(vect(-12.88, 96.7, 127.278))
        Waypoints.append(vect(0.171, 96.7, 126.669))
        Waypoints.append(vect(0.209, 95.75, 133.517))
        Waypoints.append(vect(-0.16, 95.7, 142.954))
        Waypoints.append(vect(-3.819, 95.7, 145.398))
        Waypoints.append(vect(-3.213, 95.7, 142.199))
        Waypoints.append(vect(3.465, 95.7, 141.874))
        Waypoints.append(vect(4.056, 95.7, 158.387))
        Waypoints.append(vect(-0.303, 95.7, 153.265))
        Waypoints.append(vect(-4.387, 95.7, 158.096))
        #Waypoints.append(vect(-0.052, 95.876, 168.663))
        Waypoints.append(vect(-0.077, 95.7, 177.821))
        Waypoints.append(vect(7.398, 95.7, 177.989))
        Waypoints.append(vect(-0.094, 95.7, 188.207))
        Waypoints.append(vect(-2.823, 95.7, 178.393))
        Waypoints.append(vect(-7.263, 95.7, 178.1))
        Waypoints.append(vect(-26.224, 95.75, 171.962))
        Waypoints.append(vect(-29.905, 95.75, 168.155))
        Waypoints.append(vect(-33.856, 95.75, 169.047))
        Waypoints.append(vect(-33.575, 99.7, 179.69))
        Waypoints.append(vect(-26.275, 99.7, 180.097))
        Waypoints.append(vect(-25.933, 99.7, 165.193))
        Waypoints.append(vect(-47.933, 99.7, 163.855))
        Waypoints.append(vect(-48.05, 99.7, 168.13))
        Waypoints.append(vect(-58.313, 95.7, 168.016))
        Waypoints.append(vect(-56.028, 95.7, 158.836))
        Waypoints.append(vect(-46.725, 95.7, 160.29))
        Waypoints.append(vect(-31.155, 95.7, 158.527))
        Waypoints.append(vect(-35.483, 96.7, 149.867))
        Waypoints.append(vect(-47.047, 96.599, 145.95))
        Waypoints.append(vect(-60.848, 95.687, 142.31))
        Waypoints.append(vect(-20.645, 97.7, 135.006))
        Waypoints.append(vect(-77.464, 98.264, 145.392))
        Waypoints.append(vect(-72.54, 98.278, 145.691))
        Waypoints.append(vect(27.937, 99.7, 178.58))
        Waypoints.append(vect(32.873, 99.7, 167.654))
        Waypoints.append(vect(27.885, 95.655, 170.113))
    if getCurrentObjective() == 2:
        Waypoints = []
        Waypoints.append(vect(-5.109, 268.757, 280.341))
        Waypoints.append(vect(60.315, 269.005, 341.581))
        Waypoints.append(vect(53.656, 268.313, 334.773))
        Waypoints.append(vect(39.506, 268.427, 320.696))
        Waypoints.append(vect(27.425, 268.426, 308.946))
        Waypoints.append(vect(23.551, 269.439, 304.861))
        Waypoints.append(vect(21.801, 268.423, 303.038))
        Waypoints.append(vect(13.1, 270.427, 293.912))
        Waypoints.append(vect(4.957, 271.424, 297.946))
        Waypoints.append(vect(-0.021, 271.424, 297.587))
        Waypoints.append(vect(0.028, 271.424, 304.973))
        Waypoints.append(vect(8.661, 271.424, 305.411))
        Waypoints.append(vect(-8.274, 271.424, 305.163))
        Waypoints.append(vect(-9.793, 271.424, 297.007))
        Waypoints.append(vect(0.147, 271.426, 313.598))
        Waypoints.append(vect(5.537, 271.426, 320.939))
        Waypoints.append(vect(14.925, 271.376, 320.756))
        Waypoints.append(vect(20.358, 269.361, 313.805))
        Waypoints.append(vect(4.256, 271.426, 322.821))
        Waypoints.append(vect(-7.524, 271.423, 320.822))
        Waypoints.append(vect(-2.7, 271.423, 313.403))
        Waypoints.append(vect(-10.568, 271.547, 321.621))
        Waypoints.append(vect(-17.533, 271.423, 317.518))
        Waypoints.append(vect(-26.325, 268.423, 307.675))
        Waypoints.append(vect(-21.273, 268.423, 302.708))
        Waypoints.append(vect(-32.438, 268.547, 313.467))
        Waypoints.append(vect(-28.018, 268.426, 297.091))
        Waypoints.append(vect(-12.686, 270.426, 294.225))
        Waypoints.append(vect(-17.26, 268.424, 287.968))
        Waypoints.append(vect(-17.93, 268.424, 273.244))
        Waypoints.append(vect(-20.393, 268.427, 270.468))
        Waypoints.append(vect(-14.289, 271.427, 264.259))
        Waypoints.append(vect(-3.467, 271.427, 260.494))
        Waypoints.append(vect(3.318, 271.427, 260.496))
        Waypoints.append(vect(13.474, 271.427, 262.61))
        Waypoints.append(vect(19.97, 268.423, 270.574))
        Waypoints.append(vect(16.625, 268.427, 274.866))
        Waypoints.append(vect(17.661, 268.427, 283.35))
        Waypoints.append(vect(17.161, 268.427, 288.945))
        Waypoints.append(vect(26.783, 268.427, 296.605))
        Waypoints.append(vect(11.17, 268.593, 275.447))
        Waypoints.append(vect(3.19, 268.593, 271.349))
        Waypoints.append(vect(-10.442, 268.593, 273.053))
        Waypoints.append(vect(-11.567, 268.593, 281.153))
        Waypoints.append(vect(-5.377, 268.757, 284.664))
        Waypoints.append(vect(0.057, 268.757, 284.995))
        Waypoints.append(vect(5.397, 268.757, 282.512))
        Waypoints.append(vect(3.557, 268.757, 277.935))
        Waypoints.append(vect(-2.172, 268.757, 274.819))
        Waypoints.append(vect(55.245, 267.64, 342.661))
        Waypoints.append(vect(-63.396, 268.705, 349.018))
        Waypoints.append(vect(-56.668, 267.701, 340.648))
        Waypoints.append(vect(-47.066, 266.199, 328.46))
        Waypoints.append(vect(-26.043, 271.199, 345.747))
        Waypoints.append(vect(-25.393, 271.202, 339.185))
        Waypoints.append(vect(-14.846, 271.151, 330.998))
        Waypoints.append(vect(-13.765, 271.151, 320.517))
        Waypoints.append(vect(-38.219, 268.202, 295.146))
        Waypoints.append(vect(-34.728, 268.202, 298.022))
        Waypoints.append(vect(38.217, 268.199, 295.352))
        Waypoints.append(vect(34.683, 268.202, 298.591))
        Waypoints.append(vect(27.016, 271.198, 343.073))
        Waypoints.append(vect(18.221, 271.151, 333.376))
        Waypoints.append(vect(15.165, 271.151, 331.714))
        Waypoints.append(vect(14.472, 271.151, 320.746))
        Waypoints.append(vect(-3.914, 279.201, 302.165))
        Waypoints.append(vect(0.121, 279.201, 297.518))
        Waypoints.append(vect(0.086, 279.201, 293.341))
        Waypoints.append(vect(-3.402, 271.198, 259.547))
        Waypoints.append(vect(63.561, 267.639, 337.618))
        Waypoints.append(vect(60.221, 268.647, 349.583))
        Waypoints.append(vect(49.273, 7.443, -5.441))
        Waypoints.append(vect(-46.797, 7.446, -5.746))
        Waypoints.append(vect(-60.082, 7.446, -5.322))
        Waypoints.append(vect(62.381, 7.443, -4.997))


rule "Navigation: Lijiang Tower - Jumps":
    @Event eachPlayer
    @Condition (getCurrentMap() == Map.LIJIANG_TOWER or getCurrentMap() == Map.LIJIANG_TOWER_LNY) == true
    @Condition isGameInProgress() == true
    
    if getCurrentObjective() == 0:
        JumpPointsGlobal = []
        JumpPointsGlobal.append(vect(-59.925, 3.169, -34.26))
        JumpPointsGlobal.append(vect(-14.604, -0.605, -61.834))
        JumpPointsGlobal.append(vect(-16.586, -1.545, -60.006))
        JumpPointsGlobal.append(vect(16.495, -0.835, -61.379))
        JumpPointsGlobal.append(vect(18.755, -1.612, -59.476))
        JumpPointsGlobal.append(vect(-20.346, -1.615, -54.643))
        JumpPointsGlobal.append(vect(22.271, -1.615, -54.643))
        JumpPointsGlobal.append(vect(61.865, 2.691, -34.402))
    if getCurrentObjective() == 1:
        JumpPointsGlobal = []
        JumpPointsGlobal.append(vect(-50.396, 99.129, 166.748))
        JumpPointsGlobal.append(vect(-52.31, 96.441, 163.292))
        JumpPointsGlobal.append(vect(-40.786, 100.696, 161.544))
        JumpPointsGlobal.append(vect(-31.992, 99.701, 167.633))
        JumpPointsGlobal.append(vect(-28.81, 100.642, 177.711))
        JumpPointsGlobal.append(vect(-32.072, 99.439, 177.229))
        JumpPointsGlobal.append(vect(32.384, 99.598, 177.545))
        JumpPointsGlobal.append(vect(41.602, 100.859, 161.813))
        JumpPointsGlobal.append(vect(52.116, 96.699, 163.854))
        JumpPointsGlobal.append(vect(8.545, 97.674, 126.284))
        JumpPointsGlobal.append(vect(-8.332, 97.674, 126.47))
        JumpPointsGlobal.append(vect(-1.826, 98.615, 115.751))
        JumpPointsGlobal.append(vect(2.039, 98.781, 116.011))
    if getCurrentObjective() == 2:
        JumpPointsGlobal = []
        JumpPointsGlobal.append(vect(-23.999, 268.423, 305.413))
        JumpPointsGlobal.append(vect(24.185, 268.427, 305.71))
        JumpPointsGlobal.append(vect(-4.723, 267.622, 290.543))


rule "Navigation: Lijiang Tower - Healthpacks":
    @Condition (getCurrentMap() == Map.LIJIANG_TOWER or getCurrentMap() == Map.LIJIANG_TOWER_LNY) == true
    @Condition isGameInProgress() == true
    
    if getCurrentObjective() == 0:
        HealthpackLocations = []
        HealthpackLocations.append(vect(1.46, -1.461, -81.364))
        HealthpackLocations.append(vect(14.356, 0.382, -46.801))
        HealthpackLocations.append(vect(52.983, 2.455, -31.89))
        HealthpackLocations.append(vect(-50.739, 2.573, -25.823))
        HealthpackLocations.append(vect(-12.404, 0.315, -47.261))
        HealthpackLocations.append(vect(0.903, 0.455, -9.838))
    if getCurrentObjective() == 1:
        HealthpackLocations = []
        HealthpackLocations.append(vect(26.813, 95.851, 179.147))
        HealthpackLocations.append(vect(23.699, 95.552, 144.536))
        HealthpackLocations.append(vect(-0.048, 95.552, 184.685))
        HealthpackLocations.append(vect(-23.315, 95.548, 145.334))
    if getCurrentObjective() == 2:
        HealthpackLocations = []
        HealthpackLocations.append(vect(-0.385, 271.427, 259.459))
        HealthpackLocations.append(vect(-11.615, 270.427, 292.745))
        HealthpackLocations.append(vect(-18.35, 268.426, 306.587))
        HealthpackLocations.append(vect(-0.007, 271.426, 328.087))
        HealthpackLocations.append(vect(17.889, 268.426, 306.639))
        HealthpackLocations.append(vect(11.541, 270.427, 292.691))


rule "LIJIANG 2 - FIX A":
    @Event eachPlayer
    @Condition distance(eventPlayer, vect(18.75, 95.425, 164.456)) <= 2.5
    @Condition getCurrentObjective() == 1
    @Condition (getCurrentMap() == Map.LIJIANG_TOWER or getCurrentMap() == Map.LIJIANG_TOWER_LNY) == true
    
    eventPlayer.StopAutomaticGoTo = true
    eventPlayer.stopThrottleInDirection()
    wait(0.25)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, vect(22.202, 95.425, 170.924)), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(2)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, vect(10.882, 95.425, 177.882)), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(3)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, vect(0.621, 95.425, 178.975)), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(2)
    eventPlayer.stopThrottleInDirection()
    eventPlayer.StopAutomaticGoTo = false
    wait(0.25)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentGoToTarget[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(2)
    if RULE_CONDITION:
        goto RULE_START


rule "LIJIANG 2 - FIX B":
    @Event eachPlayer
    @Condition distance(eventPlayer, vect(11.325, 95.425, 169.777)) <= 2.5
    @Condition getCurrentObjective() == 1
    @Condition (getCurrentMap() == Map.LIJIANG_TOWER or getCurrentMap() == Map.LIJIANG_TOWER_LNY) == true
    
    eventPlayer.StopAutomaticGoTo = true
    eventPlayer.stopThrottleInDirection()
    wait(0.25)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, vect(13.214, 95.425, 177.375)), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(2)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, vect(1.609, 95.425, 178.412)), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(2)
    eventPlayer.stopThrottleInDirection()
    eventPlayer.StopAutomaticGoTo = false
    wait(0.25)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentGoToTarget[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(2)
    if RULE_CONDITION:
        goto RULE_START


rule "LIJIANG 2 - FIX C":
    @Event eachPlayer
    @Condition distance(eventPlayer, vect(18.75, 95.425, 164.456)) <= 2.5
    @Condition getCurrentObjective() == 1
    @Condition (getCurrentMap() == Map.LIJIANG_TOWER or getCurrentMap() == Map.LIJIANG_TOWER_LNY) == true
    
    eventPlayer.StopAutomaticGoTo = true
    eventPlayer.stopThrottleInDirection()
    wait(0.25)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, vect(-18.532, 95.425, 164.344)), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(2)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, vect(-20.347, 95.425, 172.632)), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(3)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, vect(-7.572, 95.425, 178.509)), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(2)
    eventPlayer.stopThrottleInDirection()
    eventPlayer.StopAutomaticGoTo = false
    wait(0.25)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentGoToTarget[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(2)
    if RULE_CONDITION:
        goto RULE_START


rule "LIJIANG 2 - FIX D":
    @Event eachPlayer
    @Condition distance(eventPlayer, vect(-11.806, 95.425, 170.064)) <= 2.5
    @Condition getCurrentObjective() == 1
    @Condition (getCurrentMap() == Map.LIJIANG_TOWER or getCurrentMap() == Map.LIJIANG_TOWER_LNY) == true
    
    eventPlayer.StopAutomaticGoTo = true
    eventPlayer.stopThrottleInDirection()
    wait(0.25)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, vect(-12.602, 95.425, 177.652)), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(2)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, vect(-2.476, 95.425, 178.111)), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(2)
    eventPlayer.stopThrottleInDirection()
    eventPlayer.StopAutomaticGoTo = false
    wait(0.25)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentGoToTarget[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(2)
    if RULE_CONDITION:
        goto RULE_START
