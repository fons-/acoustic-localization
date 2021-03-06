
Fs = 502;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1620;             % Length of signal
t = (0:L-1)*T; 

freqA = 50;
freqB = 70;

phaseA = 0.0;

nMeasurement = 200;

mPhaseA = [];
mPhaseB = [];

for phaseB = linspace(0,1,nMeasurement)



	S = 0.7*sin(2*pi*(freqA*t - phaseA)) + sin(2*pi*(freqB*t - phaseB));
	X = S;
	Y = fft(X);

	A2 = abs(Y/L);
	A1 = A2(1:L/2+1);
	A1(2:end-1) = 2*A1(2:end-1);

	P2 = unwrap(angle(Y/L)*2)/2;
	P1 = P2(1:L/2 + 1);

	f = Fs*(0:(L/2))/L;
	subplot(2,1,1);
	plot(f,A1);
	title('Single-Sided Amplitude Spectrum of X(t)')
	xlabel('f (Hz)')
	ylabel('|P1(f)|')
	subplot(2,1,2);
	stem(f(1:end),P1/2/pi);

	mPhaseA = [mPhaseA; P1(1+floor(1+50/(Fs/2)* L/2))/2/pi];
	mPhaseB = [mPhaseB; P1(1+floor(1+70/(Fs/2)* L/2))/2/pi];
	
end

clf;

subplot(2,1,1);
plot(linspace(0,1,nMeasurement),1-mPhaseA);

subplot(2,1,2);
plot(linspace(0,1,nMeasurement),-mPhaseB+mPhaseA);
