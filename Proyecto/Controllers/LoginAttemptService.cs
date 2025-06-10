using System;
using System.Collections.Generic;

namespace Proyecto.Controllers
{
    public class LoginAttempt
    {
        public int Attempts { get; set; } = 0;
        public DateTime? LockedUntil { get; set; } = null;
    }

    public class LoginAttemptService
    {
        private readonly Dictionary<string, LoginAttempt> _userAttempts = new();
        private readonly object _lock = new();

        public bool IsLocked(string username, out TimeSpan tiempoRestante)
        {
            lock (_lock)
            {
                tiempoRestante = TimeSpan.Zero;

                if (_userAttempts.TryGetValue(username, out var data))
                {
                    if (data.LockedUntil.HasValue && data.LockedUntil.Value > DateTime.Now)
                    {
                        tiempoRestante = data.LockedUntil.Value - DateTime.Now;
                        return true;
                    }

                    // Si ya pasó el tiempo de bloqueo, desbloqueamos
                    if (data.LockedUntil.HasValue && data.LockedUntil.Value <= DateTime.Now)
                    {
                        _userAttempts.Remove(username);
                    }
                }

                return false;
            }
        }

        public void RegisterFailedAttempt(string username)
        {
            lock (_lock)
            {
                if (!_userAttempts.ContainsKey(username))
                {
                    _userAttempts[username] = new LoginAttempt();
                }

                _userAttempts[username].Attempts++;

                if (_userAttempts[username].Attempts >= 3)
                {
                    _userAttempts[username].LockedUntil = DateTime.Now.AddMinutes(1);
                }
            }
        }

        public void ResetAttempts(string username)
        {
            lock (_lock)
            {
                _userAttempts.Remove(username);
            }
        }

        public int GetAttemptCount(string username)
        {
            lock (_lock)
            {
                if (_userAttempts.TryGetValue(username, out var data))
                {
                    return data.Attempts;
                }

                return 0;
            }
        }
    }
}
